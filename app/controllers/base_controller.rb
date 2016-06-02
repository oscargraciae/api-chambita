class BaseController < ApplicationController
  # Errores de API
  # 400 malformed_request_error => Error cuando la llama tiene una sintaxis invalida
  # 401 authentication_error => La llamada no puede ser procesada debido a problemas de autentificacion con token
  # 402 processing_error => Cualquier proceso de error
  # 404 resource_not_found_error => El recurso solicitado no existe
  # 422 parameter_validation_error => Cuando algun parametro de la peticion es invalido
  # 500 api_error => Error con la aplicacion o con los servidores

  #Objeto API Conekta
  #Conekta.api_key="key_jaiWQwqGqEkQqqkUqhdy2A" #Llave privada de usuario

  # Este metodo nos validara el token del usuaro
  private
    def auth
      #token = request.headers["Authorization"].split(' ')[1]
      token = request.headers["Authorization"]

      if !token
        json = {:code => "unauthorized", :message => "Acceso no autorizado", :object => "error", :type => nil}
        render json: json, status: :unauthorized
      else
        token = token.split(' ')[1]
        # Validamos que el token exista y si existe almacenamos el usuario en una variable, si no existe retornamos el error
        @user = User.find_by(token: token)
        if !@user
          json = {:code => "unauthorized", :message => "Acceso no autorizado", :object => "error", :type => nil}
          render json: json, status: :unauthorized
        end
      end
    end

end
