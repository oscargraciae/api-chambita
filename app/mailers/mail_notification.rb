class MailNotification < ApplicationMailer
  default :from => 'Chambita <hello@chambita.mx>'
  layout false

  # send a signup email to the user, pass in the user object that contains the user's email address
  def send_mail_notification(user, notification)

    headers "X-SMTPAPI" => {
      "sub": {
        "%name%" => [user.first_name],
        "%notification%" => [notification]
      },
      "filters": {
        "templates": {
          "settings": {
            "enable": 1,
            "template_id": '3145ad0f-adf0-48b8-9a12-e01bfe1c5d07'
          }
        }
      }
    }.to_json

    mail( :to => user.email,:subject => 'Notificacion' )
  end
end
