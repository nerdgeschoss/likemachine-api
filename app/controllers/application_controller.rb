class ApplicationController < ActionController::API
  class NotAuthorized < StandardError
  end

  rescue_from NotAuthorized, with: :not_authorized
  rescue_from ActiveRecord::RecordInvalid, with: :record_invalid
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  def empty
    head :no_content
  end

  def cors
    expires_in 20.minutes, public: true
    head :ok
  end

  private

  def current_session
    @current_session ||= Session.find_by id: request.authorization.to_s.split(' ').second
  end

  def current_user
    @current_user ||= current_session&.user
  end

  def require_login
    head :unauthorized unless current_session
  end

  def authorize!(resource)
    if resource.author == current_user
      resource
    else
      raise NotAuthorized
    end
  end

  def not_authorized
    head :unauthorized
  end

  def record_invalid
    head :unprocessable_entity
  end

  def record_not_found
    head :not_found
  end
end
