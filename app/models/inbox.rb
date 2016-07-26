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
	belongs_to :recipient, class_name: "User"
	belongs_to :sender, class_name: "User"
	has_many :inbox_message

  scope :add_include, -> { includes(:sender, :recipient) }
  #scope :User_inbox, ->

  def self.all_inbox_by_user(user_id)
    Inbox.where('SENDER_ID = ? OR RECIPIENT_ID = ?', user_id, user_id).order(created_at: :desc).add_include()
  end


end
