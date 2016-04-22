FactoryGirl.define do
  factory :request_message do
    text "MyText"
sender_id 1
recipient_id 1
RequestService nil
  end

end
