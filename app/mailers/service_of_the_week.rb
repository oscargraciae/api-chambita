class ServiceOfTheWeek < ApplicationMailer
  default from: '<hello@chambita.mx>'
  layout 'send_email'

  def send_email(services)
    puts services.as_json
    @services = services
    # mail(to: 'oscar@chambita.mx', subject: 'Servicios de la semana')
    mail(to: 'oscar.graciae@gmail.com', subject: 'Servicios de la semana')
  end
end
