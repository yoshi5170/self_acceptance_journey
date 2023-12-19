class SelfDiscoveryTrainingsController < ApplicationController
  before_action :set_token, only: :result

  def new; end

  def result
    # 今日のトレーニング回数を取得
    today_trainings_count = current_user.self_discovery_trainings.where('trained_at >= ?', Time.zone.now.beginning_of_day).count

    if text_params.length > 50
      flash.now[:danger] = t('.text_limit')
      render :new
      return
    end

    if today_trainings_count < 2
      # OpenAIへのリクエストを行い、結果を取得
      additional_prompt = '自己分析の専門家として、ユーザーの短所を60文字以内で長所に変換してください。具体例を用い、[短所]は実は[長所]です。'
      Rails.logger.info 'Preparing to send request to OpenAI...'
      @client = OpenAI::Client.new(access_token: @api_key)
      response = @client.chat(
        parameters: {
          model: 'gpt-3.5-turbo',
          messages: [
            { role: 'system', content: additional_prompt },
            { role: 'user', content: text_params }
          ]
        }
      )
      Rails.logger.info "Received response from OpenAI: #{response.inspect}"
      @chat = response.dig('choices', 0, 'message', 'content') if response.present?

      if @chat.present?
        current_user.self_discovery_trainings.create!(trained_at: Time.current)
      else
        flash.now[:danger] = t('.fail')
        render :new
      end
    else
      redirect_to root_path, danger: t('.over_the_limit')
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
