class Admin::BaseController < ApplicationController
  layout 'admin/layouts/application'
  skip_before_action :require_login
  helper_method :admin_logged_in?
  before_action :not_authenticated

  def admin_logged_in?
    session[:admin_logged_in].present? && session[:admin_logged_in] == Rails.application.credentials.admin[:id]
  end

  def not_authenticated
    unless admin_logged_in?
      redirect_to admin_login_path, warning: t('defaults.message.require_login')
    end
  end
end
