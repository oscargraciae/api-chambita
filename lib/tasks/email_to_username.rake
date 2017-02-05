namespace :email_to_username do
  desc "Crear nombres de usuario con base al email"
  task :start => :environment do
    puts "Crear nombres de usuario con base al email"
    User.find_each do |user|
      username = User.get_username(user.email)
      # username = email.split('@')[0].gsub('_', '').gsub('.','').gsub('-','')

      user.update_attribute(:username, username)
    end
  end
end
