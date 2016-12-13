# == Schema Information
#
# Table name: unit_types
#
#  id            :integer          not null, primary key
#  description   :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  singular_name :string
#

class UnitTypeSerializer < ActiveModel::Serializer
  attributes :id, :description, :singular_name
end
