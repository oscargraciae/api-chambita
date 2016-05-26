class Api::V1::InboxController < BaseController
  before_filter  :auth, only: [:index ,:create]

  """def index
  	#listado de conversacioness
    #@inb = Inbox.find(sender_id: @user.id or recipient_id: @user.id)

  	render json: @inb, status: 200
  end"""

  #validacion de primer mensaje
  def create
  	@inb = Inbox.where(sender_id: [@user.id, params[:user_id]] , recipient_id: [@user.id, params[:user_id]]).first
	
  	if @inb
        save_inbMessage()
  	else
  		save_inbox()
	  	save_inbMessage()
    end

    render json: @inbMess,  status: 201
  end

  def save_inbox
  	puts params[:user_id]
  	inbox = Inbox.new
  	inbox.sender_id = @user.id
  	inbox.recipient_id = params[:user_id]

  	inbox.save	

  	@inb = inbox
  end

  def save_inbMessage
  	@inbMess = InboxMessage.new
    @inbMess.message = params[:message]
    @inbMess.sender_user = @user.id 
    @inbMess.inbox_id = @inb.id

    @inbMess.save
    
  end

  #metodo converación
end
