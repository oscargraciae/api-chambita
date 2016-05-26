# == Schema Information
#
# Table name: ratings
#
#  id             :integer          not null, primary key
#  rating_type_id :integer
#  value          :integer
#  evaluation_id  :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

class RatingSerializer < ActiveModel::Serializer
  attributes :id, :value
end
