class ApplicationController < ActionController::API
  rescue_from ActiveRecord::RecordNotFound, with: :not_found

  rescue_from ActionController::ParameterMissing do
    render json: { errors: "bad request" }, status: 400
  end

  def not_found
    render json: { errors: "not found" }, status: 404
  end

  private

  def respond_with(object)
    if object.valid?
      render json: object
    else
      render json: { errors: object.errors.full_messages }, status: 422
    end
  end
end
