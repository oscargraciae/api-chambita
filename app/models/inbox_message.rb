class InboxMessage < ActiveRecord::Base
  belongs_to :inbox
  belongs_to :sender, class_name: "User"#, inverse_of: :sent_messages
end
