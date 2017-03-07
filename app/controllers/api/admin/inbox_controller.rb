class Api::Admin::InboxController < ApplicationController
  def index
    messages = Inbox.all.order(id: :desc)
    render json: messages, status: :ok
  end
end
