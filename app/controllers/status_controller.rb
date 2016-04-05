class StatusController < ApplicationController

  def index
    load_status_and_messages
  end
  
  def update
    load_status_and_messages
    render :index
  end
  
  private
  
  def load_status_and_messages
    @current_status = Status.current_status
    @recent_messages = Message.recent_messages
  end
end