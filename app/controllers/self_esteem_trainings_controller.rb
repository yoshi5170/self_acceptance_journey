class SelfEsteemTrainingsController < ApplicationController
  before_action :set_token, only: :search

  def new
  end

  def search
    # OpenAIへのリクエストを行い、結果を取得
    additional_prompt = "入力された自己否定的な文を自己受容できるような文に変換して"
    #prompt = "Taking any self-deprecating statement such as '#{text_params}', rephrase it into a positive affirmation emphasizing inherent worth and personal growth in less than 30 words."
		Rails.logger.info "Preparing to send request to OpenAI..."
    @client = OpenAI::Client.new(access_token: @api_key)
    response = @client.chat(
      parameters: {
        model: "gpt-3.5-turbo",
        messages: [
          { role: "system", content: additional_prompt },
          { role: "user", content: text_params }
        ],
      }
    )
    Rails.logger.info "Received response from OpenAI: #{response.inspect}"
    @chat = response.dig("choices", 0, "message", "content") if response.present?

    # レスポンスが存在する場合、新しいトレーニングセッションを作成
    if @chat.present?
      current_user.add_training_and_flower
		else
      render :new
    end

  end


  private

  def set_token
    @api_key = Rails.application.credentials.dig(:openai, :api_key)
  end

  def text_params
    @query = params[:text]
  end
end
