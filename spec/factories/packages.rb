# == Schema Information
#
# Table name: packages
#
#  id           :integer          not null, primary key
#  title        :string
#  description  :string
#  price        :decimal(, )
#  unit_type_id :integer
#  unit_max     :integer
#  service_id   :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  is_principal :boolean          default(FALSE)
#  active       :boolean          default(TRUE)
#

FactoryGirl.define do
  factory :package do
    title "MyString"
    description "MyString"
    price "9.99"
    unit_type_id 1
    unit_max 1
    service_id ""
  end
end
