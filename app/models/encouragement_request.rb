class EncouragementRequest < ApplicationRecord
  has_one_attached :request_image
  belongs_to :user
  validates :text, presence: true, length: { maximum: 150 }
  validates :background_id, presence: true, numericality: { only_integer: true }
end
