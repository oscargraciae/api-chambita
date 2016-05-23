FactoryGirl.define do
  factory :inbox_message do
    message "MyString"
sender_user 1
inbox nil
  end

end
