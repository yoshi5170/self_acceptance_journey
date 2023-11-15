class Admin::FlowersController < Admin::BaseController
  before_action :set_flower, only: %i[edit update destroy]

  def index
    @flowers = Flower.all.order(threshold: :asc)
  end

  def new
    @flower = Flower.new
  end

  def create
    @flower = Flower.new(flower_params)
    if @flower.save
      redirect_to admin_flowers_path
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @flower.update(flower_params)
      redirect_to admin_flowers_path, success: '花を更新しました'
    else
      flash.now[:danger] = '花の更新に失敗しました'
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @flower.destroy!
    redirect_to admin_flowers_path, success: '花を削除しました'
  end

  private

  def set_flower
    @flower = Flower.find(params[:id])
  end

  def flower_params
    params.require(:flower).permit(:name, :threshold, :flower_image)
  end
end
