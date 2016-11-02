# == Schema Information
#
# Table name: ratings
#
#  id             :integer          not null, primary key
#  rating_type_id :integer
#  value          :integer
#  evaluation_id  :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

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

  # def self.get_ratings_by_service_id(service_id)
  #
  # 	ratings = Rating.joins(:evaluation).select("SUM(value) as value, rating_type_id, COUNT(*)").where(evaluations: {service_id: service_id}).group(:rating_type_id)
  #
  # 	rating_hash = Hash.new
  # 	ratings_array = Array.new
  # 	avg_general = 0
  #
  # 	ratings.each do |rating|
  # 		avg = rating.value.to_f / rating.count
  # 		avg_general = avg_general + avg
  #
  # 		rating_hash = {"rating_type" => rating.rating_type_id, "rating" => avg.round(1)}
  # 		ratings_array.push(rating_hash)
  # 	end
  # 	ratings_array
  # end

  def self.get_ratings_by_subcategory(subcategory_id, supplier_id)
    ratings = Rating.joins(:evaluation).select('SUM(value) as value, rating_type_id, COUNT(*)').where(evaluations: { subcategory_id: subcategory_id, supplier_id: supplier_id }).group(:rating_type_id)

    rating_hash = {}
    ratings_array = []
    avg_general = 0

    ratings.each do |rating|
      avg = rating.value.to_f / rating.count
      avg_general += avg

      rating_hash = { 'rating_type' => rating.rating_type_id, 'rating' => avg.round(1) }
      ratings_array.push(rating_hash)
    end
    ratings_array
  end

  def self.update_rating_by_subcategory(subcategory_id, supplier_id)
    rating_total = 0

    ratings = get_ratings_by_subcategory(subcategory_id, supplier_id)
    ratings.each do |x|
      rating_total += x['rating']
    end

    avg = rating_total / ratings.count

    Service.where(sub_category_id: subcategory_id).where(user_id: supplier_id).update_all(rating_general: avg)
    # Service.find(service_id).update_attribute(:rating_general, avg)
  end
end
