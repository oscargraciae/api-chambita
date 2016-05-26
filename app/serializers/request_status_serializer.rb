# == Schema Information
#
# Table name: request_statuses
#
#  id         :integer          not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class RequestStatusSerializer < ActiveModel::Serializer
  attributes :id, :name
end
