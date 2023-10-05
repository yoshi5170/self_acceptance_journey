class Admin::UserSessionsController < Admin::BaseController
  skip_before_action :not_authenticated, only: %i[new create]
  layout 'admin_login'

  def new; end

  def create
    email = Rails.application.credentials.admin[:email]
    password = Rails.application.credentials.admin[:password]
    id = Rails.application.credentials.admin[:id]

    if params[:email] == email && params[:password] == password
      session[:admin_logged_in] = id
      redirect_to admin_root_path, success: t('.success')
    else
      flash.now[:danger] = t('.fail')
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    session.delete(:admin_logged_in)
    redirect_to admin_login_path, success: t('.success'), status: :see_other
  end
end
