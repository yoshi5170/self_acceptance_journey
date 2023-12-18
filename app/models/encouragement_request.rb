class EncouragementRequest < ApplicationRecord
  has_one_attached :request_image
  belongs_to :user
  has_many :encouragement_messages
  validates :text, presence: true, length: { maximum: 150 }
  validates :status, presence: true
  validates :background_id, presence: true, numericality: { only_integer: true }
  validates :request_image, presence: true, blob: { content_type: ['image/png'] }
  enum status: { draft: 0, public_status: 1 }
end
