class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable
  has_many :services

  before_create :generate_authentication_token!

  do_not_validate_attachment_file_type :avatar
  has_attached_file   :avatar,
                        :styles => { :small => ["216x144!",:jpg], :meddium => ["230x230!",:jpg], :thumb => ["216x144#", :jpg]},
                        :default_style => :meddium,
                        :storage => :s3,
                        :url  => ':s3_domain_url',
                        :default_url => 'http://chambita1236.s3.amazonaws.com/uploads/users/:style/user_default.png',
                        :path => "uploads/users/:file_id/:style/:filename"


  def generate_authentication_token!
    begin
      self.token = Devise.friendly_token
    end while self.class.exists?(token: token)
  end

end
