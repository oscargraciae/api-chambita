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

FactoryGirl.define do
  factory :rating do
    rating_type nil
value 1
evaluation nil
  end

end
