class ApplicationController < ActionController::Base
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
  rescue_from ActiveRecord::RecordInvalid, with: :record_invalid
  rescue_from StandardError, with: :standard_error

  private

  def record_not_found(exception)
    redirect_to root_path, alert: "Record not found: #{exception.message}"
  end

  def record_invalid(exception)
    redirect_back fallback_location: root_path, alert: "Invalid record: #{exception.message}"
  end

  def standard_error(exception)
    redirect_back fallback_location: root_path, alert: "An error occurred: #{exception.message}"
  end
end
