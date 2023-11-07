class Admin::BaseController < ApplicationController
  before_action :authenticate_user!
  before_action :check_admin
  layout 'admin/layouts/application'

  private

  def check_admin
    return if current_user.admin?

    redirect_to root_path, warning: '権限がありません。'
  end
end
