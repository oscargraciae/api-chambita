class InboxSerializer < ActiveModel::Serializer
  attributes :id, :sender, :recipient, :full_name

  	def sender
		object.sender
	end

	def recipient
		object.recipient
	end

	def full_name
    	"#{object.sender.first_name} #{object.sender.last_name}"
  	end
end
	