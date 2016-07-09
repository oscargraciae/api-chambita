class Api::V1::EvaluationsController < BaseController
	before_filter :auth, only: [:create]

	def index
		service = Service.find(params[:service_id])
		evaluations = Evaluation.where(subcategory_id: service.sub_category_id, supplier_id: service.user_id).includes(:user, :ratings)

		render json: evaluations, status: :ok
	end

	def create

		request = RequestService.joins(:service).find(params[:request_id])

		if !request.is_evaluated
			evaluation = Evaluation.new
			evaluation.service_id = params[:service_id]
			evaluation.supplier_id = request.supplier.id
			evaluation.subcategory_id = request.service.sub_category_id
			evaluation.comment = params[:comment]
			evaluation.user_id = @user.id

			if evaluation.save
				# Hacemos los registros para los rating
				Rating.set_ratings(params[:ratings], evaluation)
				Rating.update_rating_by_subcategory(evaluation.subcategory_id, evaluation.supplier_id)

				request.update_attribute(:is_evaluated, true)
				render json: request, status: :ok
			else
				render json: evaluation.errors, status: :ok

			end

		else
			render json: {message: "Este servicio ya se ha evaluado"}, status: :ok
		end

	end

	def params_evaluation
		params.permit(:service_id, :comment)
	end


end
