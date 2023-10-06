class ApplicationController < ActionController::Base
  add_flash_types :success, :info, :warning, :danger
  before_action :require_login

  private

  def not_authenticated
    redirect_to root_url, warning: t('defaults.message.require_login')
  end
end
