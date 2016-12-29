class Api::Admin::InboxController < ApplicationController
  def index
    messages = Inbox.all
    render json: messages, status: :ok
  end
end
