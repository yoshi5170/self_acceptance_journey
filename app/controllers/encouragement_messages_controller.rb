class EncouragementMessagesController < ApplicationController
  before_action :set_encouragement_message, only: %i[show edit update destroy]
  skip_before_action :authenticate_user!
  before_action :set_encouragement_request, only: [:index]

  def index
    @encouragement_messages = @encouragement_request.encouragement_messages
  end

  def new
    @encouragement_request = EncouragementRequest.find(params[:request_id])
    @request_user = @encouragement_request.user.name
    @encouragement_message = EncouragementMessage.new(encouragement_request_id: @encouragement_request.id)
  end

  def create
    @encouragement_message = EncouragementMessage.new(encouragement_message_params)
    @encouragement_request = @encouragement_message.encouragement_request
    @request_user = @encouragement_request.user.name
    if @encouragement_message.background_id.blank?
      flash.now[:danger] = '画像を選択してください'
      render :new and return
    end

    attach_message_image

    if @encouragement_message.save
      redirect_to encouragement_message_path(@encouragement_message), success: '画像を作成しました'
    else
      flash.now[:danger] = '画像の作成に失敗しました'
      render :new, status: :unprocessable_entity
    end
  end

  def show
    Rails.logger.info "Encouragement Request Image URL: #{url_for(@encouragement_message.encouragement_request.request_image)}"
  end

  def edit
    @request_user = @encouragement_message.encouragement_request.user.name
  end

  def update
    @request_user = @encouragement_message.encouragement_request.user.name
    @encouragement_message.update(encouragement_message_params)
    image = ImageCreator.build(@encouragement_message.text, @encouragement_message.background_id)
    image_path = image.path
    @encouragement_message.message_image.attach(io: File.open(image_path), filename: 'message_image.png', content_type: 'image/png')
    if @encouragement_message.save
      redirect_to encouragement_message_path(@encouragement_message), success: '画像を作成しました'
    else
      flash.now[:danger] = '画像の作成に失敗しました'
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @encouragement_message.destroy
    redirect_to root_path, success: 'メッセージカードの送信を取り消しました'
  end

  private

  def set_encouragement_message
    @encouragement_message = EncouragementMessage.find_by(id: params[:id])
  end

  def encouragement_message_params
    params.require(:encouragement_message).permit(:text, :background_id, :encouragement_request_id)
  end

  def set_encouragement_request
    @encouragement_request = EncouragementRequest.find(params[:encouragement_request_id])
  end

  def attach_message_image
    image = ImageCreator.build(@encouragement_message.text, @encouragement_message.background_id)
    image_path = image.path
    @encouragement_message.message_image.attach(io: File.open(image_path), filename: 'message_image.png', content_type: 'image/png')
  end
end
