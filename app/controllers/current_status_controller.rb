class CurrentStatusController < ApplicationController

  def index
    @current_status = Status.current_status
    @recent_messages = Message.recent_messages
  end
end