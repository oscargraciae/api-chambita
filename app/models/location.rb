# == Schema Information
#
# Table name: locations
#
#  id                  :integer          not null, primary key
#  location            :string
#  geo_lat             :decimal(9, 6)
#  geo_lng             :decimal(9, 6)
#  route               :string
#  locality            :string
#  administrative_area :string
#  country             :string
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#

class Location < ActiveRecord::Base
  has_one :user
end
