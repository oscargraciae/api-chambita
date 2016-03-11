class Api::V1::UsersController < BaseController
  before_filter :auth, only: [:show, :update, :destroy]
  respond_to :json

  # GET api/v1/users
  def index
    render json: User.all, status: :ok
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

      msj = ""
      msj += user.errors[:email].any? ? "Esa dirección de correo electrónico ya está en uso. " : " "
      msj += user.errors[:password].any? ? "Tu contraseña debe tener al menos 8 caracteres. " : " "

	    render json: { :errors => user.errors, :message => msj  }, status: 422
	  end
 end

# PUT api/v1/users/:id
 def update
   # user = @user
   user = User.find(params[:id])
   if user.update(user_params)
      render json: user, status: 200
   else
      render json: { :errors => user.errors, :message => "Esa dirección de correo electrónico ya está en uso."  }, status: 200
   end
 end

 # DELETE api/v1/users/:id
 def destroy
 end

 # Validamos los parametros de entrada
 def user_params
    params.permit(:first_name, :last_name, :email, :password, :birthdate, :cellphone, :description, :avatar, :encrypted_password)
 end

end
