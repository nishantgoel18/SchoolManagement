module Api
  class ApplicationController < ActionController::Base
    include Pundit::Authorization

    skip_before_action :verify_authenticity_token

    def current_user
      @current_user ||= user_type.constantize.find_by(authentication_token: token)
    end

    def authenticate_user_request!
      user = user_type.constantize.find_by(authentication_token: token)
      if user.blank?
        return invalid_authentication
      end
    end

    def token
      request.headers["Authorization"]
    end

    def user_type
      request.headers["UserType"].present? ? request.headers["UserType"] : ''
    end

    def invalid_authentication
      render json: {error: 'Invalid Authtoken', status: :unauthorized}, status: :unauthorized
    end

    rescue_from Pundit::NotAuthorizedError do |exception|
      policy = exception.policy
      policy_name = exception.policy.class.to_s.underscore

      render json: {error: 'Unauthorized', status: :unauthorized}, status: :unauthorized
    end
  end
end
