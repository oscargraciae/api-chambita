# == Schema Information
#
# Table name: inbox_messages
#
#  id          :integer          not null, primary key
#  message     :string
#  sender_user :integer
#  inbox_id    :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class InboxMessage < ActiveRecord::Base
  belongs_to :sender, class_name: "User", foreign_key: "sender_user"
end
