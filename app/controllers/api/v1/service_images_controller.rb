class Api::V1::ServiceImagesController < BaseController
  before_filter :auth, only: [:create, :destroy]

	def create
		service_image = ServiceImage.new
		service_image.caption = ""
		service_image.service_id = params[:service_id]
		service_image.photo = params[:photo]

		if service_image.save
      		render json: service_image, status: 200
	    else
	      	render json: {errors: service_image.errors}, status: 422
	    end
	end

	def destroy
    	service_image = ServiceImage.find(params[:id])
    	service_image.destroy
    	head 204
  	end
end
