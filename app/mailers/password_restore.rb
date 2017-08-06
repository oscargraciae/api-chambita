class PasswordRestore < ApplicationMailer

  default :from => 'Gigbox <hello@gigbox.mx>'
  layout false
  # send a signup email to the user, pass in the user object that   contains the user's email address
  def send_password_reset(user)

    headers "X-SMTPAPI" => {
      "sub": {
        "%name%" => [user.first_name],
        "%url%" => ['https://gigbox.mx/password-reset?t='+user.token]
      },
      "filters": {
        "templates": {
          "settings": {
            "enable": 1,
            "template_id": '071da3f3-9d1e-4739-b0e1-b7dfdd5a8c36'
          }
        }
      }
    }.to_json

    @user = user
    mail( :to => @user.email,:subject => 'Restaurar contraseña' )
  end
end
