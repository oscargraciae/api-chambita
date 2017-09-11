class Api::V1::InboxController < BaseController
  before_filter :auth, only: [:index, :preview_inbox, :create, :all_messages, :show, :get_by_user]

  def index
    inb = Inbox.all_inbox_by_user(@user.id)
    render json: inb, status: :ok
  end

  def show
    # El id es es el id del usuario con el que se habla
    inbox = Inbox.where(sender_id: [@user.id, params[:id]], recipient_id: [@user.id, params[:id]]).first
    render json: inbox, status: 200
  end

  def get_by_id
    inbox = Inbox.find(params[:id])
    messages = InboxMessage.where(inbox_id: inbox.id)
    if messages
      messages.update_all(read: true)
    end

    render json: inbox, status: 200
  end

  def get_by_user
    from_user = User.find_by(username: params[:id])

    if from_user
      inbox = Inbox.between(@user.id, from_user.id).first
      if inbox
        messages = InboxMessage.where(inbox_id: inbox.id)
        if messages
          messages.update_all(read: true)
        end

        render json: inbox, status: 200
      else
        
        render json: {error: true, message: "No hay mensajes con esté usuario"}, status: 200
      end
    else
      render json: {error: true, message: "Usuario no encontrado"}, status: 200
    end
    
  end

  # def create
  #   if !params[:inbox_id]
  #     @inb = Inbox.where(sender_id: [@user.id, params[:user_id]], recipient_id: [@user.id, params[:user_id]]).first
  #   else
  #     @inb = Inbox.find(params[:inbox_id])
  #   end

  #   if @inb
  #     save_inbMessage
  #   else
  #     save_inbox
  #     save_inbMessage
  #   end

  #   render json: @inbMess, status: 201
  # end

  def create
    if Inbox.between(params[:sender_id], params[:recipient_id]).present?
      @inbox = Inbox.between(params[:sender_id], params[:recipient_id]).first

      inbox_message = InboxMessage.where(inbox_id: @inbox.id).last
      puts "#####################"
      puts inbox_message.as_json

      if inbox_message.sender_user != params[:sender_id]
        sendNotification(params[:recipient_id], params[:message])
      end
      
      save_inbox_message

    else
      @inbox = Inbox.create!(conversation_params)
      save_inbox_message
      if Rails.env.production?
        reply
        sendNotification(params[:recipient_id], params[:message])
      end
    end

    render json: @inbMess, status: 201
  end

  def preview_inbox
    inboxes_preview = InboxMessage.joins(:inbox).where("(INBOXES.RECIPIENT_ID = #{@user.id} OR INBOXES.SENDER_ID = #{@user.id}) AND READ = false").where.not(sender_user: @user.id).size
    render json: inboxes_preview, status: :ok
  end

  # def save_inbox
  #   inbox = Inbox.new
  #   inbox.sender_id = @user.id
  #   inbox.recipient_id = params[:user_id]
  #   if inbox.save
  #     @inb = inbox

  #     if Rails.env.production?
  #       reply
  #     end
  #   end

  # end

  def save_inbox_message
    @inbMess = InboxMessage.new
    @inbMess.message = params[:message]
    @inbMess.sender_user = params[:sender_id]
    @inbMess.inbox_id = @inbox.id

    if @inbMess.save
      @inbox.update_attribute(:updated_at, DateTime.now)
      # sendNotification(params[:recipient_id])
    end

  end

  # metodo conversación
  def all_messages
    inb = InboxMessage.where(inbox_id: params[:inboxId])

    read = inb.where('sender_user != ?', @user.id)
    read.update_all "read = 'true'"

    render json: inb.order(id: :asc), status: :ok
  end

  private
  def sendNotification(id, message)
    if @inbox
      user_res = User.find(id)
      email_content = "#{@user.first_name} te ha enviado un mensaje, revisa tu bandeja de entrada en www.gigbox.mx"
      subject = "#{@user.first_name} te ha enviado un mensaje"
      url = "https://gigbox.mx/conversation/#{@user.username}"
      MessageNotification.send_mail_notification(user_res, email_content, user_res.email, message, url, @user.first_name, subject).deliver
    end
  end


  private
  def reply
    user_id = 0
    # user_id = if @user.id == @inb.sender_id
    #             @inb.recipient_id
    #           else
    #             @inb.sender_id
    #           end

    boot_twilio
    user_res = User.find(params[:recipient_id])
    if user_res.cellphone
      # from_number = "+528115258753"
      from_number = "+52#{user_res.cellphone}"
      sms = @client.messages.create(
        from: '+18326267620',
        to: from_number,
        body: "#{@user.first_name} te ha enviado un mensaje, revisa tu bandeja de entrada en gigbox.mx"
      )
    end

  end

  private
  def boot_twilio
    account_sid = 'AC8d936b8298b25c1820624a58f0b67466'
    auth_token = 'ee5404c1235be5117b91bb2919f87249'
    @client = Twilio::REST::Client.new account_sid, auth_token
  end

  private
  def conversation_params
    params.permit(:sender_id, :recipient_id)
  end  

end
