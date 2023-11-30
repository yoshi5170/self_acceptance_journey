class Admin::MonthlyThemesController < Admin::BaseController
  before_action :set_monthly_theme, only: %i[edit update destroy]
  def index
    @monthly_themes = MonthlyTheme.all
  end

  def new
    @monthly_theme = MonthlyTheme.new
  end

  def create
    @monthly_theme = MonthlyTheme.new(monthly_theme_params)
    if @monthly_theme.save
      redirect_to admin_monthly_themes_path, success: '月のテーマを作成しました'
    else
      flash.new[:danger] = '月のテーマの作成に失敗しました'
      render :new, status: :unprocessable_entity
    end
  end

  def edit; end

  def update
    if @monthly_theme.update(monthly_theme_params)
      redirect_to admin_monthly_themes_path, success: '月のテーマを更新しました'
    else
      flash.new[:danger] = '質問作成に失敗しました'
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @monthly_theme.destroy!
    redirect_to admin_monthly_themes_path, success: '月のテーマを削除しました'
  end

  private

  def set_monthly_theme
    @monthly_theme = MonthlyTheme.find(params[:id])
  end

  def monthly_theme_params
    params.require(:monthly_theme).permit(:month, :title, :message)
  end
end
