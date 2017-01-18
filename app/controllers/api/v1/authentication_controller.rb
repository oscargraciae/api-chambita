require 'net/http'
require 'httparty'

class Api::V1::AuthenticationController < BaseController
  def create
    user_password = params[:password]
    user_email = params[:email]
    user = user_email.present? && User.find_by(email: user_email)

    if user
      if user.valid_password? user_password
        # sign_in user, store: false
        if !user.token
          user.generate_authentication_token!
          user.save
        end

        us = MeSerializer.new(User.find(user.id))
        #UserNotifier.send_signup_email(us).deliver
        render json: {:user => us, :token => user.token}, status: 200
      else
        render json: { :errors => user.errors, :status => "error", :message => "Contraseña incorrecta" }, status: 200
      end
    else
      render json: { :status => "error", :message => "Correo electrónico no existe o es incorrecto." }, status: 200
    end

  end

  def facebook
    access_token_url = 'https://graph.facebook.com/v2.3/oauth/access_token'
    graph_api_url = 'https://graph.facebook.com/v2.5/me?fields=id,email,cover,first_name,last_name,picture.width(500).height(500)'

    par = {
        'client_id': params[:clientId],
        'redirect_uri': params[:redirectUri],
        'client_secret': '616734ecf6d122801b13c4ab37556bc1',
        'code': params[:code]
    }

    response = HTTParty.get(access_token_url, :query => par)
    access_t = response.parsed_response

    response = HTTParty.get(graph_api_url, :query => access_t)
    resp = response.parsed_response

    user = User.find_by(facebook_id: resp["id"])
    if user
      if !user.token
        user.generate_authentication_token!
        user.save
      end

      us = MeSerializer.new(User.find(user.id))
      #UserNotifier.send_signup_email(us).deliver
      render json: {:user => us, :token => user.token}, status: 200
    else
      user = User.new
      user.first_name = resp["first_name"]
      user.last_name = resp["last_name"]
      user.email = resp["email"]
      user.password = "123456899"
      user.facebook_id = resp["id"]
      user.avatar = resp["picture"]["data"]["url"]
      user.username = User.get_username(resp["email"])

      if user.save
        render json: {:user => user, :token => user.token}, status: 200
      else
        render json: user.errors, status: :ok
      end

    end

  end

  def destroy
    user = User.find_by(token: params[:id])
    user.generate_authentication_token!
    user.save
    head 204
  end

end
