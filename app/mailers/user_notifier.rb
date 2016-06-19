class UserNotifier < ApplicationMailer
  default :from => 'prueba@chambita.com'
  layout "send_signup_email"
  # send a signup email to the user, pass in the user object that   contains the user's email address
  def send_signup_email(user)

    headers "X-SMTPAPI" => {
      "sub": {
        "%name%" => [user.first_name]
      },
      "filters": {
        "templates": {
          "settings": {
            "enable": 1,
            "template_id": 'ed98b18b-56c0-4500-81f3-b2a0133a11b8'
          }
        }
      }
    }.to_json

    @user = user
    mail( :to => @user.email,:subject => 'Por favor, confirma tu dirección de correo electrónico - Chambita' )
  end
end
