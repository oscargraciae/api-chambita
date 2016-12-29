class ServiceOfTheWeek < ApplicationMailer
  default from: 'Chambita <hello@chambita.mx>'
  layout 'send_email'

  def send_email(services, email, nombre)
    @services = services
    # mail(to: 'oscar@chambita.mx', subject: 'Servicios de la semana')
    mail(to: email, subject: "Hola #{nombre}, estos son los servicios de la semana")
  end
end
