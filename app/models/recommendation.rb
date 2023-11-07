class Recommendation < ApplicationRecord
  belongs_to :result
  validates :title, presence: true, length: { maximum: 255 }
  validates :description, presence: true, length: { maximum: 65_535 }
end
