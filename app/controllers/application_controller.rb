class ApplicationController < ActionController::Base
    helper_method :current_user, :user_signed_in?

    private

    def authenticate_user!
      redirect_to root_path unless session[:user_id]
    end

    def current_user
      return unless session[:user_id]
      @current_user ||= User.find_by(uid: session[:user_id])
    end

    def user_signed_in?
      !!session[:user_id]
    end
end
