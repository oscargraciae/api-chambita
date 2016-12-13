# == Schema Information
#
# Table name: evaluations
#
#  id             :integer          not null, primary key
#  user_id        :integer
#  service_id     :integer
#  comment        :string
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  supplier_id    :integer
#  subcategory_id :integer
#

class EvaluationSerializer < ActiveModel::Serializer
  attributes :id, :comment, :created_at
  # has_one :user, serializer: UserShortSerializer
  has_one :user, serializer: UserShortSerializer
  # has_one :service
  has_many :ratings
end
