class Admin::UnlockableFlowersController < Admin::BaseController
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

  private

  def unlockable_flower_params
    params.require(:unlockable_flower).permit(:name, :threshold, :flower_image)
  end
end
