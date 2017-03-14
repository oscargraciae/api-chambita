class Api::V1::InboxController < BaseController
  before_filter :auth, only: [:index, :preview_inbox, :create, :all_messages]

  def index
    inb = Inbox.all_inbox_by_user(@user.id)
    render json: inb, status: :ok
  end

  def create
    if !params[:inbox_id]
      @inb = Inbox.where(sender_id: [@user.id, params[:user_id]], recipient_id: [@user.id, params[:user_id]]).first
    else
      @inb = Inbox.find(params[:inbox_id])
    end

    if @inb
      save_inbMessage
    else
      save_inbox
      save_inbMessage
    end

    render json: @inbMess, status: 201
  end

  def preview_inbox

    inboxes_preview = InboxMessage.joins(:inbox).where("(INBOXES.RECIPIENT_ID = #{@user.id} OR INBOXES.SENDER_ID = #{@user.id}) AND READIT = false").where.not(sender_user: @user.id).size
    render json: inboxes_preview, status: :ok
  end

  def save_inbox
    inbox = Inbox.new
    inbox.sender_id = @user.id
    inbox.recipient_id = params[:user_id]
    if inbox.save
      @inb = inbox
      reply
    end

  end

  def save_inbMessage
    @inbMess = InboxMessage.new
    @inbMess.message = params[:message]
    @inbMess.sender_user = @user.id
    @inbMess.inbox_id = @inb.id

    if @inbMess.save
      @inb.update_attribute(:updated_at, DateTime.now)
      sendNotification(@user.id)
    end

  end

  # metodo conversación
  def all_messages
    inb = InboxMessage.where(inbox_id: params[:inboxId])

    read = inb.where('sender_user != ?', @user.id)
    read.update_all "readit = 'true'"

    render json: inb.order(id: :asc), status: :ok
  end

  private
  def sendNotification(id)
    user_id = 0

    if @inb
      user_id = if id == @inb.sender_id
                  @inb.recipient_id
                else
                  @inb.sender_id
                end

      user_res = User.find(user_id)
      email_content = "#{@user.first_name} te ha enviado un mensaje, revisa tu bandeja de entrada en www.chambita.mx"
      MailNotification.send_mail_notification(user_res, email_content).deliver
    end
  end


  private
  def reply
    user_id = 0
    user_id = if @user.id == @inb.sender_id
                @inb.recipient_id
              else
                @inb.sender_id
              end

    boot_twilio
    user_res = User.find(user_id)
    if user_res.cellphone
      # from_number = "+528115258753"
      from_number = "+52#{user_res.cellphone}"
      sms = @client.messages.create(
        from: '+18326267620',
        to: from_number,
        body: "#{@user.first_name} te ha enviado un mensaje, revisa tu bandeja de entrada en chambita.mx"
      )
    end

  end

  private
  def boot_twilio
    account_sid = 'AC8d936b8298b25c1820624a58f0b67466'
    auth_token = 'ee5404c1235be5117b91bb2919f87249'
    @client = Twilio::REST::Client.new account_sid, auth_token
  end

end
