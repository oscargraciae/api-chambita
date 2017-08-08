class Api::V1::UsersController < BaseController
  before_filter :auth, only: [:update, :destroy, :me_show, :avatar, :password, :update_CLABE, :resend_email]

  # GET api/v1/users
  # def index
  #  render json: User.all, status: :ok
  # end

  # GET api/v1/users/:id
  # GET api/v1/users/:username
  def show
    # user = User.find(params[:id])
    user = User.find_by(username: params[:id])
    render json: user, status: :ok
  end

  # GET api/v1/users/:id
  def me_show
    user = User.find(@user.id)
    render json: user, serializer: MeSerializer, status: :ok
  end

  # POST api/v1/users
  def create
    user = User.new(user_params)
    user.username = User.get_username(user.email)
    if user.save
      if Rails.env.production?
        #UserNotifier.send_signup_email(user).deliver
        UserDetail.user_signup_detail(user).deliver
      end

      render json: user, status: 201
    else

      msj = ''
      msj += user.errors[:email].any? ? 'Esa dirección de correo electrónico ya está en uso. ' : ' '
      msj += user.errors[:password].any? ? 'Tu contraseña debe tener al menos 8 caracteres. ' : ' '

      render json: { status: 'error', errors: user.errors, message: msj }, status: 200
     end
  end

  def active_account
    user = User.find_by(token: params[:token_user])

    if user.update_attribute(:IsActiveEmail, true)
      render json: { status: 'ok' }, status: 200
    else
      render json: { status: 'error' }, status: 200
    end
  end

  def valid_token
    user = User.find_by(token: params[:token_user])
    
    if user
      render json: user.id, status: 200
    else
      render json: { status: 'error' }, status: 200
    end
  end

  def password_reset
    user = User.find_by(token: params[:token_user], id: params[:id])

    if params[:password] == params[:password_confirmation]

      if user.update_attribute(:password, params[:password])
        render json: { status: true }, status: 200
      end

    else
      render json: { status: false, message: 'Tus nuevas contraseñas no coinciden. Por favor, inténtalo de nuevo.' }, status: 422
    end
  end

  def send_password_email
    user = User.find_by(email: params[:email])

    if user
      PasswordRestore.send_password_reset(user).deliver
      render json: user, status: 200
    else
      render json: { status: false, message: 'El correo ingresado no existe' }, status: 200
    end
  end

  # PUT api/v1/users/:id
  def update
    user = User.find(@user.id)

    if !params[:address].blank?
      user.address = params[:address]

      location = Geocoder.search(params[:address])[0]

      user.lat = params[:lat]
      user.lng = params[:lng]
      user.country = location.country
      user.state = location.state
      user.city = location.city
      user.is_completed = true
    end

    if user.update(user_params)
      render json: user, serializer: MeSerializer, status: 200
    else
      render json: { errors: user.errors, message: 'Esa dirección de correo electrónico ya está en uso.' }, status: 200
    end
  end

  # def update_address
  #     user = User.find(@user.id)
  #     if user.update(user_params)
  #       render json: user, serializer: MeSerializer, status: 200
  #     else
  #       render json: { errors: user.errors, message: 'Error' }, status: 500
  #     end
  # end

  def avatar
    user = User.find(@user.id)
    if user.update_attribute(:avatar, params[:avatar])
      render json: user, serializer: MeSerializer, status: 200
    else
      render json: { errors: user.errors }, status: 422
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
          render json: { status: true }, status: 200
        end
      else
        render json: { status: false, message: 'Tu antigua contraseña es incorrecta. Por favor, inténtalo de nuevo.' }, status: 200
      end
    else
      render json: { status: false, message: 'Tus nuevas contraseñas no coinciden. Por favor, inténtalo de nuevo.' }, status: 200
    end
  end

  def update_CLABE
    @user = User.find(params[:id])

    if @user.update_attributes(clabe: params[:clabe], bank: params[:bank])
      render json: @user, serializer: MeSerializer, status: 200
      # render json: {status: true, message: "Se han actualizado tus datos."}, status: 200
    else

      render json: { status: false, message: 'No se ha podido actualizar los datos.' }, status: 200
    end
  end

  def resend_email
    UserNotifier.send_signup_email(@user).deliver

    render json: { status: true }, status: 200
  end

  # DELETE api/v1/users/:id
  def destroy
  end

  # Validamos los parametros de entrada
  def user_params
    params.permit(:first_name, :last_name, :email, :password, :password_confirmation, :birthdate, :cellphone, :description, :encrypted_password, :address_street, :address_area, :address_zipcode, :cellphone, :lat, :lng)
  end

  def prueba
    render json: params, status: :ok
  end
end
