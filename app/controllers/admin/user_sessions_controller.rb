class Admin::UserSessionsController < Admin::BaseController
  skip_before_action :not_authenticated, only: %i[new create]
  layout 'admin_login'
  def new
  end

  def create
    email = Rails.application.credentials.admin[:email]
    password = Rails.application.credentials.admin[:password]
    id = Rails.application.credentials.admin[:id]

    if params[:email] == email && params[:password] == password
      session[:admin_logged_in] = id
      redirect_to admin_root_path
    else
      render :new
    end
  end

  def destroy
    session.delete(:admin_logged_in)
    redirect_to admin_login_path#, notice: t('defaults.message.logged_out')
  end
end
