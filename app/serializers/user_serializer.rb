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

class UserSerializer < ActiveModel::Serializer
  attributes :id, :first_name, :last_name, :full_name, :description, :avatar, :avatar_thumb, :address
  # has_many :services, serializer: ServicePublicDetailSerializer
  #has_many :services, serializer: ServicePrivateSummarySerializer

  # def services
  #   object.services.where(published: true, isActive: true)
  # end

  def avatar_thumb
  	object.avatar.url(:thumb)
  end

  def address
  	[object.city, object.state, object.country].compact.join(', ')
  end

  def full_name
    "#{object.first_name} #{object.last_name}"
  end

end
