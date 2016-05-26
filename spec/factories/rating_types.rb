# == Schema Information
#
# Table name: rating_types
#
#  id          :integer          not null, primary key
#  name        :string
#  description :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

FactoryGirl.define do
  factory :rating_type do
    name "MyString"
description "MyString"
  end

end
