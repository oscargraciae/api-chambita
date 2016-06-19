class Api::V1::AuthenticationController < BaseController

  # before_filter :destroy

  def create
    user_password = params[:password]
    user_email = params[:email]
    user = user_email.present? && User.find_by(email: user_email)

    if user.valid_password? user_password
      # sign_in user, store: false
      user.generate_authentication_token!
      user.save

      us = MeSerializer.new(User.find(user.id))
      UserNotifier.send_signup_email(us).deliver
      render json: {:user => us, :token => user.token}, status: 200
    else
      render json: { :errors => user.errors, :message => "Correo electrónico o contraseña incorrecto" }, status: 422
    end
  end

  def destroy
    user = User.find_by(token: params[:id])
    user.generate_authentication_token!
    user.save
    head 204
  end

end
