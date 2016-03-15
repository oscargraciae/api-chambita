class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable
  belongs_to :locations
  has_many :services

  before_create :generate_authentication_token!

  """do_not_validate_attachment_file_type :avatar #No es seguro
  has_attached_file :avatar,
      :storage => :fog,
      :fog_credentials => {
                            :provider                 => 'AWS',
                            :aws_access_key_id        => 'AKIAJE2VWUVEX5WUBB5Q',
                            :aws_secret_access_key    => '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',
                            :region                   => 'eu-west-1',
                            :path_style               => true
                          },
        :fog_directory => 'chambita1236',
        :fog_region    => 'eu-west-1'"""
        
        #:fog_host => 'chambita1236.s3-website-us-west-1.amazonaws.com'
  do_not_validate_attachment_file_type :avatar
  has_attached_file   :avatar,
                        :default_url => '/assets/user_default.png',
                        :styles => { :small => ["90x90!",:jpg], :meddium => ["230x230!",:jpg]},
                        :default_style => :meddium,
                        :storage => :s3,
                        :url  => ':s3_domain_url',
                        :path => "uploads/:file_id/:style/:filename"


  def generate_authentication_token!
    begin
      self.token = Devise.friendly_token
    end while self.class.exists?(token: token)
  end

  def set_image
    StringIO.open(Base64.decode64(image_json)) do |data|
      data.class.class_eval { attr_accessor :original_filename, :content_type }
      data.original_filename = "file.jpg"
      data.content_type = "image/jpeg"
      self.image = data
    end
  end

end
