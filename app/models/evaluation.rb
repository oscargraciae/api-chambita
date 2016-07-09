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
  has_many :ratings, dependent: :delete_all

  def self.delete_by_service_id(service_id)
    evaluations = Evaluation.where(service_id: service_id)

    evaluations.each do |e|
      Rating.where(evaluation_id: e.id).delete_all
    end
    evaluations.delete_all

  end

end
