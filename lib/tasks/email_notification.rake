namespace :email_notification do
  task :send => :environment do
    suppliers = User.joins("INNER JOIN Services ON services.user_id = users.id").distinct.order(created_at: :desc)
    suppliers.each do |user|
        NotificationsSms.send_email(user.email).deliver
    end
    # NotificationsSms.send_email("oscar").deliver
  end
end
