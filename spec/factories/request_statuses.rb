# == Schema Information
#
# Table name: request_statuses
#
#  id         :integer          not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

FactoryGirl.define do
  factory :request_status do
    name "MyString"
  end

end
