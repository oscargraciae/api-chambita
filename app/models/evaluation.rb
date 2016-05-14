class Evaluation < ActiveRecord::Base
  belongs_to :user
  belongs_to :service
  has_many :ratings
end
