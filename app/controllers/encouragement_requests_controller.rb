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

  def preview
    @encouragement_request = EncouragementRequest.new(text: encouragement_request_params[:text])
    @image_id = encouragement_request_params[:image_id]
    image = ImageCreator.build(@encouragement_request.text, @image_id)
    image_path = image.path
    @encouragement_request.request_image.attach(io: File.open(image_path), filename: 'request_image.png', content_type: 'image/png')
    render :preview, status: :unprocessable_entity
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

  def show;end

  def edit
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
    params.require(:encouragement_request).permit(:text, :request_image, :image_id)
  end
end
