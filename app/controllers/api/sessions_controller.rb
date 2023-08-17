module Api
  class SessionsController < Api::ApplicationController

    def login
      user = User.find_by(email: params[:email]&.downcase)

      if user&.authenticate?(params[:password])
        render json: {token: user.authentication_token, status: 'ok'}
      else
        render json: {status: 'error'}, status: 401
      end
    end
  end
end
