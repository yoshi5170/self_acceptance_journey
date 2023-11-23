class EncouragementRequestsController < ApplicationController
  before_action :set_encouragement_request, only: %i[show edit update destroy]

  def index
  end

  def select_image;end

  def new
    @encouragement_request = EncouragementRequest.new
    # @encouragement_request.image_id = params[:image_id]
    @image_id = params[:image_id].to_i
  end

  def create
    @encouragement_request = current_user.encouragement_requests.build(encouragement_request_params)
    image = ImageCreator.build(@encouragement_request.text, @encouragement_request.background_id)
    image_path = image.path
    @encouragement_request.request_image.attach(io: File.open(image_path), filename: 'request_image.png', content_type: 'image/png')

    if @encouragement_request.save
      redirect_to encouragement_request_path(@encouragement_request), success: '画像を作成しました'
    else
      flash.now[:danger] = '画像の作成に失敗しました'
      render :new, status: :unprocessable_entity
    end
  end

  def show
    Rails.logger.info "Encouragement Request Image URL: #{url_for(@encouragement_request.request_image)}"
  end

  def edit; end

  def update
    @encouragement_request.update(encouragement_request_params)
    image = ImageCreator.build(@encouragement_request.text, @encouragement_request.background_id)
    image_path = image.path
    @encouragement_request.request_image.attach(io: File.open(image_path), filename: 'request_image.png', content_type: 'image/png')
    if @encouragement_request.save
      redirect_to encouragement_request_path(@encouragement_request), success: '画像を作成しました'
    else
      flash.now[:danger] = '画像の作成に失敗しました'
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @encouragement_request.destroy
    redirect_to select_image_encouragement_requests_path, success: '画像を削除しました'
  end

  private

  def set_encouragement_request
    @encouragement_request = current_user.encouragement_requests.find_by(id: params[:id])
  end

  def encouragement_request_params
    params.require(:encouragement_request).permit(:text, :request_image, :background_id)
  end
end
