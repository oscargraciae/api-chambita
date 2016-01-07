class Api::V1::AuthenticationController < BaseController

  before_filter :destroy

  def create
    user_password = params[:user][:password]
    user_email = params[:user][:email]
    user = user_email.present? && User.find_by(email: user_email)

    if user.valid_password? user_password
      sign_in user, store: false
      user.generate_authentication_token!
      user.save
      render json: user, status: 200
    else
      render json: { errors: "Correo electrónico o contraseña incorrecto" }, status: 422
    end
  end

  def destroy
    user = User.find_by(token: params[:id])
    user.generate_authentication_token!
    user.save
    head 204
  end

end
