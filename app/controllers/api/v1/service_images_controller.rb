class Api::V1::ServiceImagesController < BaseController

 	def index
    	render json: "prueba....", status: :ok
  	end

	def create
		
		service_image = ServiceImage.new
		service_image.caption = "prueba..."
		service_image.service_id = params[:service_id]
		service_image.photo = params[:photo]

		if service_image.save
			#s = ServiceImage.find(service_image.id)
			#puts s.as_json
			#s.update_attribute(:photo, params[:photo])
      		render json: service_image, status: 200
	    else
	      	render json: {errors: service_image.errors}, status: 422
	    end
	end
end
