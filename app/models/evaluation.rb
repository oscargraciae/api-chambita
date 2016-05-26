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

class Evaluation < ActiveRecord::Base
  belongs_to :user
  belongs_to :service
  has_many :ratings
end
