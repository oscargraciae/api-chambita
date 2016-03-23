class Api::V1::UsersController < BaseController
  before_filter :auth, only: [:show, :update, :destroy]
  
  # GET api/v1/users
  def index
    render json: User.all, status: :ok
  end

# GET api/v1/users/:id
 def show
   user = User.find(params[:id])
   # user.avatar = user.avatar.path(:thumb)
   render json: user
   #render json: {user: user, avatar: user.avatar, url: user.avatar.url(:thumb)}
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

 def avatar
    user = User.find(params[:id])
    
    """File.open('app/assets/profile_avatar'+params[:id]+'.jpg', 'wb') do|f|
      f.write(Base64.decode64(params[:avatar]))
    end"""
    
    if user.update_attribute(:avatar, params[:avatar])
      render json: {status: true, user: user}, status: 200
    else
      render json: {errors: user.errors}, status: 422
    end
 end

 # DELETE api/v1/users/:id
 def destroy
 end

 # Validamos los parametros de entrada
 def user_params
    params.permit(:first_name, :last_name, :email, :password, :birthdate, :cellphone, :description, :avatar, :encrypted_password, :lat, :lng)
 end

end
