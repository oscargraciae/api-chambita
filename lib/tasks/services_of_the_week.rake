namespace :services_of_the_week do
  desc "Envio de correo servicios de la semana"
  task :daily => :environment do
    begin
      puts "Envio de correo servicios de la semana"
      services = Service.joins(:user, :packages).where(isActive: true, published: true).distinct(:name).order(created_at: :desc).limit(14)
      # ServiceOfTheWeek.send_email(services).deliver
      User.find_each do |user|
        ServiceOfTheWeek.send_email(services, user.email, user.first_name).deliver
      end
    rescue => ex
      puts ex.message
    end
  end
end
