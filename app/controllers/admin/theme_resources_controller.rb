class Admin::ThemeResourcesController < Admin::BaseController
  before_action :set_theme_resource, only: %i[edit update destroy]
  def index
    @theme_resources = ThemeResource.all
  end

  def new
    @theme_resource = ThemeResource.new
  end

  def create
    month_param = theme_resource_params[:month]
    monthly_theme = MonthlyTheme.find_by(month: month_param)
    @theme_resource = monthly_theme.theme_resources.new(content: theme_resource_params[:content], url: theme_resource_params[:url])
    if @theme_resource.save
      redirect_to admin_theme_resources_path, success: '月のテーマを作成しました'
    else
      flash.now[:danger] = '月のテーマの作成に失敗しました'
      render :new, status: :unprocessable_entity
    end
  end

  def edit; end

  def update
    if @theme_resource.update(content: theme_resource_params[:content], url: theme_resource_params[:url])
      redirect_to admin_theme_resources_path, success: '月のテーマを更新しました'
    else
      flash.now[:danger] = '質問作成に失敗しました'
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @theme_resource.destroy!
    redirect_to admin_theme_resources_path, success: '月のテーマを削除しました'
  end

  private

  def set_theme_resource
    @theme_resource = ThemeResource.find(params[:id])
  end

  def theme_resource_params
    params.require(:theme_resource).permit(:month, :content, :url)
  end
end
