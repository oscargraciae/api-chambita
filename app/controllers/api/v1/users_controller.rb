class Api::V1::UsersController < BaseController
  before_filter :auth, only: [:show, :update, :destroy, :me_show, :avatar, :password]

  # GET api/v1/users
  #def index
  #  render json: User.all, status: :ok
  #end

# GET api/v1/users/:id
 def show
   user = User.find(params[:id])
   render json: user
 end

 # GET api/v1/users/:id
 def me_show
   user = User.find(@user.id)
   render json: MeSerializer.new(user), status: :ok
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

	    render json: {:status => "error", :errors => user.errors, :message => msj  }, status: 200
	  end
 end

# PUT api/v1/users/:id
 def update

   user = User.find(@user.id)
   location = Geocoder.search(params[:address])[0]

   user.lat = location.coordinates[0]
   user.lng = location.coordinates[1]
   user.country = location.country
   user.state = location.state
   user.city = location.city

   if user.update(user_params)
      render json: MeSerializer.new(user), status: 200
   else
      render json: { :errors => user.errors, :message => "Esa dirección de correo electrónico ya está en uso."  }, status: 200
   end
 end

  def avatar
    user = User.find(@user.id)
    if user.update_attribute(:avatar, params[:avatar])
      render json: {status: true, user: MeSerializer.new(user) }, status: 200
    else
      render json: {errors: user.errors}, status: 422
    end
  end

  def password
    @user = User.find(@user.id)

    # validamos que la nueva contraseña
    if params[:password] == params[:password_confirmation]

      # validamos la contraseña actual
      if @user.valid_password? params[:current_password]

        # actualizamos la contraseña
        if @user.update_attribute(:password, params[:password])
          render json: {status: true}, status: 200
        end
      else
        render json: {status: false, message: "Tu antigua contraseña era incorrecta. Por favor, inténtalo de nuevo."}, status: 422
      end
    else
      render json: {status: false, message: "Tus nuevas contraseñas no coinciden. Por favor, inténtalo de nuevo."}, status: 422
    end
  end

 # DELETE api/v1/users/:id
 def destroy
 end

 # Validamos los parametros de entrada
 def user_params
    params.permit(:first_name, :last_name, :email, :password, :password_confirmation, :birthdate, :cellphone, :description, :encrypted_password, :address_street, :address_area, :address_zipcode, :cellphone)
 end

 def prueba
  render json: params, status: :ok
 end

end
