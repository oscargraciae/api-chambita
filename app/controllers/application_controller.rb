class ApplicationController < ActionController::Base
  def index
    render file: 'app/assets/index.html'
  end
end
