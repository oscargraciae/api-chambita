# == Schema Information
#
# Table name: evaluations
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  service_id :integer
#  comment    :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

FactoryGirl.define do
  factory :evaluation do
    user nil
service nil
comment "MyString"
  end

end
