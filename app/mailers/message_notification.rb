class MessageNotification < ApplicationMailer
  default :from => 'Gigbox <hello@chambita.mx>'
  layout false

  def send_mail_notification(user, notification, email, message, url, sender_name, subject)

    headers "X-SMTPAPI" => {
      "sub": {
        "%name%" => [user.first_name],
        "%notification%" => [notification],
        "%subject%" => [subject],
        "%sender_name%" => [sender_name],
        "%message%" => [message],
        "%url%" => [url],
      },
      "filters": {
        "templates": {
          "settings": {
            "enable": 1,
            "template_id": 'e2d8b6c9-474e-407c-890f-509671187a6d'
          }
        }
      }
    }.to_json

    mail( :to => email,:subject => subject )
  end
end
