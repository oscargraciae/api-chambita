# == Schema Information
#
# Table name: categories
#
#  id   :integer          not null, primary key
#  name :string           not null
#

class Category < ActiveRecord::Base
  has_many :sub_categories
end
