class UserDetail < ApplicationMailer
  default :from => '<hello@chambita.mx>'
  layout "user_signup_detail"

  def user_signup_detail(user)
    @user = user
    mail( :to => "chambitamx@gmail.com",:subject => 'Nuevo usuario' )
  end

end
