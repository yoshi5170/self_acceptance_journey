class EncouragementRequestsController < ApplicationController
  before_action :set_encouragement_request, only: %i[show edit update destroy status_update]
  skip_before_action :authenticate_user!, only: %i[index]
  def index
    if params[:message_id].present?
      @encouragement_message = EncouragementMessage.find(params[:message_id])
    end
    @encouragement_requests = EncouragementRequest.where(status: 'public_status').includes(:user).order(created_at: :desc).page(params[:page]).per(18)
  end

  def draft
    @encouragement_requests = current_user.encouragement_requests.where(status: 'draft').includes(:user).order(created_at: :desc).page(params[:page]).per(18)
  end

  def select_image; end

  def new
    @encouragement_request = EncouragementRequest.new
    # @encouragement_request.image_id = params[:image_id]
    @image_id = params[:image_id].to_i
  end

  def create
    @encouragement_request = current_user.encouragement_requests.build(encouragement_request_params)
    @image_id = @encouragement_request.background_id
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

  def status_update
    if @encouragement_request.update(status: status_params)
      redirect_to encouragement_request_path(@encouragement_request), success: 'ステータスを変更にしました'
    else
      flash.now[:danger] = 'ステータスの変更に失敗しました'
      render :show, status: :unprocessable_entity
    end
  end

  def destroy
    @encouragement_request.destroy
    redirect_to encouragement_requests_path, success: '画像を削除しました'
  end

  private

  def set_encouragement_request
    @encouragement_request = current_user.encouragement_requests.find_by(id: params[:id])
  end

  def encouragement_request_params
    params.require(:encouragement_request).permit(:text, :request_image, :background_id, :status)
  end

  def status_params
    if params[:commit] == '公開する'
      'public_status'
    else
      'draft'
    end
  end
end
