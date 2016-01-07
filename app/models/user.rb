class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable
  belongs_to :locations
  has_many :services

  before_create :generate_authentication_token!

  def generate_authentication_token!
    begin
      self.token = Devise.friendly_token
    end while self.class.exists?(token: token)
  end

end
