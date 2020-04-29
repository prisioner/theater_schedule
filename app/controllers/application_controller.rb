class ApplicationController < ActionController::API
  rescue_from ActiveRecord::RecordNotFound, with: :not_found

  def not_found
    render json: { errors: :not_found }, status: 404
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
