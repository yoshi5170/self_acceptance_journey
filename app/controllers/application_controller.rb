class ApplicationController < ActionController::Base
  before_action :require_login

  private

  def require_login
    unless logged_in?
      redirect_to root_url
    end
  end
end
