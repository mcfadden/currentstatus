class Api::V1::CurrentStatusController < Api::V1::BaseController

  skip_before_action :verify_authenticity_token

  def index
    load_status_and_messages
  end

  def update
    @error = "Must provide status or message" if params[:status].blank? && params[:message].blank?
    if params[:status].present?
      unless Status.update_current_status(params[:status])
        @error = "Invalid Status"
      end
    end
    Message.create(content: params[:message]) if params[:message].present?

    load_status_and_messages
    if @error.present?
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