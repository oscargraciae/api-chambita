# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  first_name             :string
#  last_name              :string
#  password               :string
#  birthdate              :datetime
#  cellphone              :string
#  description            :text
#  avatar                 :text
#  token                  :text
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  location_id            :integer
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :inet
#  last_sign_in_ip        :inet
#  avatar_file_name       :string
#  avatar_content_type    :string
#  avatar_file_size       :integer
#  avatar_updated_at      :datetime
#  lat                    :float
#  lng                    :float
#  country                :string
#  state                  :string
#  city                   :string
#  address_street         :string
#  address_area           :string
#  address_zipcode        :string
#  conektaid              :string
#

class User < ActiveRecord::Base

  validates :first_name, length: { maximum: 30 }
  validates :last_name, length: { maximum: 30 }
  validates :email, length: { maximum: 254 }
  #validates :address , length: { maximum: 30 }
  validates :description , length: { maximum: 400 }
  validates :address_street, length: { maximum: 60 }
  validates :address_area, length: { maximum: 60 }
  validates :address_zipcode, length: { maximum: 6 }
  validates :cellphone, length: { maximum: 15 }

  has_many :sent_messages, class_name: "RequestMessage", foreign_key: "sender_id"
  has_many :received_messages, class_name: "RequestMessage", foreign_key: "recipient_id"
  has_many :notifications, dependent: :destroy
  has_many :services

  belongs_to :supplier, class_name: "RequestService", foreign_key: "supplier_id"

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable


  before_create :generate_authentication_token!

  do_not_validate_attachment_file_type :avatar
  #validates_attachment :avatar, :content_type => { :content_type => ["image/jpeg", "image/gif", "image/png"] }
  #validates_attachment :avatar, presence: true, content_type: { content_type: "image/jpeg" }, size: { in: 0..10.kilobytes }
  has_attached_file   :avatar,
                        :styles => { :small => ["216x144!",:jpg], :meddium => ["230x230!",:jpg], :thumb => ["216x144#", :jpg]},
                        :default_style => :meddium,
                        :storage => :s3,
                        :url  => ':s3_domain_url',
                        :default_url => 'https://s3-us-west-1.amazonaws.com/chambita1236/uploads/users/user1.png',
                        :path => "uploads/users/:file_id/:style/:filename"

  def generate_authentication_token!
    begin
      self.token = Devise.friendly_token
    end while self.class.exists?(token: token)
  end

end
