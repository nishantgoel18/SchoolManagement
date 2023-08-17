class ApplicationController < ActionController::Base
  include ApplicationHelper
  include Pundit::Authorization

  helper_method :current_user
  helper_method :authenticate_user! 
  helper_method :user_signed_in?

  rescue_from Pundit::NotAuthorizedError do |exception|
    policy = exception.policy
    policy_name = exception.policy.class.to_s.underscore

    redirect_to((request.referrer || root_path), notice: 'Access denied!')
  end
end
