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

class InboxMessageSerializer < ActiveModel::Serializer
  attributes :id, :message, :readit, :created_at, :sender_name, :sender_user
  has_one :sender

  def sender_name
    object.sender.first_name
  end

  def message
    # m = object.message.to_s.gsub(/^\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*$/, '(email hidden)')
    m = object.message.to_s.gsub(/(?<=[ ])[\d \-+()]+$|(?<=[ ])[\d \-+()]+(?=[ ]\w)/, '(TELEFONO OCULTO)')
    m = m.to_s.gsub(/\b[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}\b/i, '(EMAIL OCULTO)')

    puts m
    m
  end

end
