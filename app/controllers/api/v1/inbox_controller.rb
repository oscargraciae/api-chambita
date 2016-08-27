class Api::V1::InboxController < BaseController
  before_filter  :auth, only: [:index, :preview_inbox, :create, :all_messages]

  def index
    inb = Inbox.all_inbox_by_user(@user.id)
    render json: inb, status: :ok
  end

  def create
    #validacion de primer mensaje
    if !params[:inbox_id]
      @inb = Inbox.where(sender_id: [@user.id, params[:user_id]] , recipient_id: [@user.id, params[:user_id]]).first
    else
      @inb = Inbox.find(params[:inbox_id])
    end

  	if @inb
        save_inbMessage()
  	else
      user_res = User.find(params[:user_id])
      email_content = "#{@user.first_name} te ha enviado un mensaje, revisa tu bandeja de entrada"
      MailNotification.send_mail_notification(user_res, email_content).deliver

  		save_inbox()
	  	save_inbMessage()
    end

    render json: @inbMess,  status: 201
  end

  def preview_inbox
    #inboxes_preview = InboxMessage.joins(:inbox).where("(INBOXES.RECIPIENT_ID = #{@user.id} OR INBOXES.SENDER_ID = #{@user.id}) AND READIT = false").size
    inboxes_preview = InboxMessage.joins(:inbox).where("(INBOXES.RECIPIENT_ID = #{@user.id} OR INBOXES.SENDER_ID = #{@user.id}) AND READIT = false").where.not(sender_user: @user.id).size
    render json: inboxes_preview, status: :ok
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
