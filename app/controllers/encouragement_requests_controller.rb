class EncouragementRequestsController < ApplicationController
  def index
  end

  def select_image;end

  def new
    @encouragement_request = EncouragementRequest.new
    # @encouragement_request.image_id = params[:image_id]
    @image_id = params[:image_id].to_i
  end

  def create
    @encouragement_request = current_user.encouragement_requests.build(text: params[:encouragement_request][:text])
    @image_id = params[:encouragement_request][:image_id]
    image = ImageCreator.build(@encouragement_request.text, @image_id)
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
    @encouragement_request = current_user.encouragement_requests.find_by(id: params[:id])
  end

  def edit
  end

  private

  def encouragement_request_params
    params.require(:encouragement_request).permit(:text, :request_image, :image_id)
  end
end
