class MonthlyTheme < ApplicationRecord
  has_many :theme_resources, dependent: :destroy
  validates :month, presence: true, numericality: { only_integer: true }
  validates :title, presence: true, length: { maximum: 255 }
  validates :message, presence: true, length: { maximum: 65_535 }

  def self.send_monthly_notification(month)
    monthly_theme = find_by(month:)
    return unless monthly_theme

    resources_text = monthly_theme.theme_resources.map do |resource|
      "・#{resource.content}: \n #{resource.url}"
    end
    contents = resources_text.join("\n")

    message = {
      type: 'text',
      text: "#{monthly_theme.month}月のテーマは#{monthly_theme.title}です🌸\n\n【メッセージ】\n\n #{monthly_theme.message}\n\n【関連コンテンツ】 \n\n #{contents}"
    }

    response = LINE_BOT_CLIENT.broadcast(message)
    Rails.logger.info("Sent message to LINE: #{response}")
  end
end
