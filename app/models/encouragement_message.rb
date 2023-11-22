class EncouragementMessage < ApplicationRecord
  has_one_attached :message_image
  belongs_to :encouragement_request
  validates :text, presence: true, length: { maximum: 150 }
  validates :background_id, presence: true, numericality: { only_integer: true }
end
