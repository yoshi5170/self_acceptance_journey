class SessionsController < ApplicationController
  def create
    @user = User.from_omniauth(request.env["omniauth.auth"])
    session[:user_id] = @user.uid
    redirect_to request.env["omniauth.origin"] || root_url
  end

  def destroy
    reset_session
    redirect_to root_url, status: :see_other
  end

  def failure
    redirect_to root_url
  end

end
