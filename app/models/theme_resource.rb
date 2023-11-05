class ThemeResource < ApplicationRecord
  belongs_to :monthly_theme
  validates :content, presence: true, length: { maximum: 255 }
  validates :url, presence: true, length: { maximum: 255 }
end