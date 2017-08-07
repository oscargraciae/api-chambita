# == Schema Information
#
# Table name: inboxes
#
#  id           :integer          not null, primary key
#  sender_id    :integer
#  recipient_id :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class Inbox < ActiveRecord::Base
  belongs_to :recipient, class_name: 'User'
  belongs_to :sender, class_name: 'User'
  has_many :inbox_message

  validates_uniqueness_of :sender_id, :scope => :recipient_id

  scope :add_include, -> { includes(:sender, :recipient) }
  # scope :User_inbox, ->
  scope :between, -> (sender_id, recipient_id) do
    where('(inboxes.sender_id =? AND inboxes.recipient_id =?) OR (inboxes.sender_id = ? AND inboxes.recipient_id =?)', sender_id,recipient_id, recipient_id, sender_id)
  end

  def self.all_inbox_by_user(user_id)
    Inbox.where('SENDER_ID = ? OR RECIPIENT_ID = ?', user_id, user_id).order(updated_at: :desc).add_include
  end

  
end
