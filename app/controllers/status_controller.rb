class StatusController < ApplicationController

  skip_before_action :verify_authenticity_token, only: :update

  def index
    @current_status = Status.current_status
    @recent_messages = Message.recent_messages
  end
  
  def update
    @error = "Must specify status, message, or both" if params[:message].blank? && params[:status].blank?
    
    if params[:status].present?
      unless Status.update_current_status(params[:status])
        @error = "Invalid Status"
      end
    end
    Message.create(content: params[:message]) if params[:message].present?

    if @error.present?
      render text: @error, status: 400
    else
      render text: "ok"
    end
  end
end