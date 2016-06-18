# == Schema Information
#
# Table name: categories
#
#  id   :integer          not null, primary key
#  name :string           not null
#

class CategorySerializer < ActiveModel::Serializer
  attributes :id, :name
  #has_many :sub_categories
end
