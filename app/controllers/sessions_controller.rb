class SessionsController < ApplicationController
  before_action :redirect_if_logged_in, except: [:destroy]
  def new
  end
  def create
    user = User.find_by(email: params[:email])
    if user && user.authenticate?(params[:password])
      cookies[:token] = user.authentication_token
      redirect_to '/', notice: 'Successfully Logged In!'
    else
      redirect_to '/login', notice: "Invalid Email or Password" 
    end
  end
  def destroy
    cookies[:token] = nil
    redirect_to '/login', notice: "Successfully Logged Out!"
  end

  private
  def redirect_if_logged_in
    redirect_to '/', notice: 'You are already logged in' if user_signed_in?
  end
end