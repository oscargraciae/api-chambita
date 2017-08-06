class NotificationsSms < ApplicationMailer
  default from: 'Gigbox <ayuda@gigbox.mx>'
  layout false

  def send_email(email)
    headers "X-SMTPAPI" => {
      "sub": {},
      "filters": {
        "templates": {
          "settings": {
            "enable": 1,
            "template_id": 'ed63a5ec-589c-4364-90e9-c03a02db46c4'
          }
        }
      }
    }.to_json

    # mail(to: 'oscar@chambita.mx', subject: 'No pierdas ventas - Chambita')
    mail(to: email, subject: "No pierdas ventas - Gigbox")
  end
end
