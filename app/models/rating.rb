class Rating < ActiveRecord::Base
  belongs_to :rating_type
  belongs_to :evaluation


  def self.set_ratings(ratings, evaluation)

  	ratings.each do |r|
		rating = Rating.new
		
		rating.rating_type_id = r[:rating_type]
		rating.value = r[:score]
		rating.evaluation_id = evaluation.id
		rating.save

	end

  end

end
