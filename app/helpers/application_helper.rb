module ApplicationHelper

  def current_user
    @current_user ||= User.find_by(authentication_token: session[:token]) if session[:token] 
  end
  
  def authenticate_user!
    redirect_to '/login', notice: 'Please login to continue' unless current_user 
  end

  def user_signed_in?
    current_user.present?
  end
end
