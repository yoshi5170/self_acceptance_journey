class Admin::UnlockableFlowersController < Admin::BaseController
  before_action :set_unlockable_flower, only: %i[edit update destroy]

  def index
    @unlockable_flowers= UnlockableFlower.all
  end

  def new
    @unlockable_flower = UnlockableFlower.new
  end


  def create
    @unlockable_flower = UnlockableFlower.new(unlockable_flower_params)
    if @unlockable_flower.save
      redirect_to admin_unlockable_flowers_path
    else
      render :new
    end
  end

  def edit; end

  def update
    if @unlockable_flower.update(unlockable_flower_params)
      redirect_to admin_unlockable_flowers_path, success: '花を更新しました'
    else
      flash.now[:danger] = '花の更新に失敗しました'
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @unlockable_flower.destroy!
    redirect_to admin_unlockable_flowers_path, success: '質問を削除しました'
  end

  private

  def set_unlockable_flower
    @unlockable_flower = UnlockableFlower.find(params[:id])
  end

  def unlockable_flower_params
    params.require(:unlockable_flower).permit(:name, :threshold, :flower_image)
  end
end
