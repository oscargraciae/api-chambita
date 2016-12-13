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
#  readit      :boolean          default(FALSE)
#

require 'rails_helper'

RSpec.describe InboxMessage, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
