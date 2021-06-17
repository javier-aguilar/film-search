class ApplicationController < ActionController::API
  def error(message, status)
    render json: { message: message }, status: status
  end
end
