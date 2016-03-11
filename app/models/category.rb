class Category < ActiveRecord::Base
  has_many :sub_categories
  belongs_to :service
end
