class SendManualEmail < ActionMailer::Base
  default from: '<hello@chambita.mx>'
  layout 'manual_email'

  def manual_email
    puts "Enviando email"
    mail(to: "oscar@gigbox.mx", subject: 'Hola!')
  end
end


#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
