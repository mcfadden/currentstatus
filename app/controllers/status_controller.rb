class StatusController < ApplicationController

  skip_before_action :verify_authenticity_token, only: :update

  def index
    load_status_and_messages
  end
  
  def update
    if params[:status].present?
      unless Status.update_current_status(params[:status])
        @errors ||= []
        @errors << "Invalid Status"
      end
    end
    Message.create(content: params[:message]) if params[:message].present?

    load_status_and_messages
    if @errors.present?
      render :index, status: 400
    else
      render :index
    end
  end
  
  private
  
  def load_status_and_messages
    @current_status = Status.current_status
    @recent_messages = Message.recent_messages
  end
end