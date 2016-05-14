class EvaluationSerializer < ActiveModel::Serializer
  attributes :id, :comment, :created_at
  #has_one :user, serializer: UserShortSerializer
  has_one :user, serializer: UserShortSerializer
  #has_one :service
  has_many :ratings
  
  
end
