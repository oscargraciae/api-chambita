class Api::V1::UsersController < BaseController
  before_filter :auth, only: [:show, :update, :destroy]
  respond_to :json

  # GET api/v1/users
  def index
    # json = {:message => User.all}
    # render json: json, status: :ok
  end

# GET api/v1/users/:id
 def show
   user = User.find(params[:id])
   render json: user
 end

# POST api/v1/users
 def create
   user = User.new(user_params)
   if user.save
	    render json: user, status: 201
	  else
	    render json: { errors: user.errors }, status: 422
	  end
 end

# PUT api/v1/users/:id
 def update
   user = @user

   if user.update(user_params)
      render json: user, status: 200
   else
      render json: { errors: user.errors  }, status: 422
   end
 end

 # DELETE api/v1/users/:id
 def destroy
 end

 # Validamos los parametros de entrada
 def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :birthdate, :cellphone, :description, :avatar, :encrypted_password)
 end

end
