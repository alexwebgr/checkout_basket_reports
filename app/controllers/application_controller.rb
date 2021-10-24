class ApplicationController < ActionController::API
  rescue_from ActiveRecord::RecordNotFound, with: ->(e) { record_not_found(e) }

  def record_not_found(e)
    render json: { message: e.message }, status: :not_found
  end
end
