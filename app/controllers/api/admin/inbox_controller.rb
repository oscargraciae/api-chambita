class Api::Admin::InboxController < ApplicationController
  def index
    messages = Inbox.all.order(id: :desc)
    render json: messages, status: :ok
  end

  def get_by_id
    inbox = Inbox.find(params[:id])
    messages = InboxMessage.where(inbox_id: inbox.id)
    if messages
      messages.update_all(read: true)
    end

    render json: inbox, serializer: AdminInboxSerializer,  status: 200
  end
  
end
