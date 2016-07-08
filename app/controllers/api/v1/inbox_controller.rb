class Api::V1::InboxController < BaseController
  before_filter  :auth, only: [:index, :create, :all_messages]

  def index
    #listado de conversacioness
    inb = Inbox.all_inbox_by_user(@user.id)

    render json: {inbox: ActiveModel::ArraySerializer.new(inb), count: inb.size}, status: :ok
  end

  def create
    #validacion de primer mensaje
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

  #metodo conversación
  def all_messages
    inb = InboxMessage.where(inbox_id: params[:inboxId])

    read = inb.where('sender_user != ?', @user.id)
    read.update_all "readit = 'true'"

    render json: inb.order(id: :asc), status: :ok
  end
end
