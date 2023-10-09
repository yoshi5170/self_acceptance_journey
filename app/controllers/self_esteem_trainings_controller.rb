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
    #@chat = "私のプレゼンテーションのスキルはまだ改善の余地がありますが、他の人と比べて自分を貶める必要はないと気づきました。失敗から学び、成長することができるチャンスです。私は自分自身を大切にし、自己価値を持ち続けることを選びます。
              #私のプレゼンテーションのスキルはまだ改善の余地がありますが、他の人と比べて自分を貶める必要はないと気づきました。失敗から学び、成長することができるチャンスです。私は自分自身を大切にし、自己価値を持ち続けることを選びます。"
    # レスポンスが存在する場合、新しいトレーニングセッションを作成
    # if @chat.present?
    #   @training = current_user.self_negation_trainings.create(trained_at: Time.current)
    #   add_flower_to_garden
		# else
    #   render :new
    # end

  end


  private

  def set_token
    @api_key = Rails.application.credentials.dig(:openai, :api_key)
  end

  def text_params
    @query = params[:text]
  end

	def add_flower_to_garden
		#トレーニングをした合計回数を取得
    total_trainings = current_user.self_negation_trainings.count + positive_conversion_trainings.count

		return if total_trainings == 0 # トレーニング回数が0の場合は何もしない

    # unlockable_flowersをthresholdの昇順で取得
		#例）[花A: threshold 10,　花B: threshold 35, 花C: threshold 65, 花D: threshold 100, 花E: threshold 145, 花F: threshold 195]
    flowers = UnlockableFlower.order(threshold: :asc)

		#total_trainings（トータルのトレーニング回数）がflower.threshold（各花が解禁されるためのトレーニング完了回数の閾値）以下であるかどうかを判断
		flowers.each do |flower|
	    if total_trainings <= flower.threshold
	      flower_to_add = flower
	      break
	    end
	  end

    if flower_to_add
      current_user.planted_flowers.create(unlockable_flower: flower_to_add, added_at: Time.current)
    end
  end
end
