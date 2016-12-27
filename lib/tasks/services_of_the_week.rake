namespace :services_of_the_week do
  desc "Envio de correo servicios de la semana"
  task :daily => :environment do
    puts "Correo semanal enviado"
    services = Service.joins(:user, :packages).where(isActive: true, published: true).order(created_at: :desc).limit(8)
    ServiceOfTheWeek.send_email(services).deliver
  end
end
