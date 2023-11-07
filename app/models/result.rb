class Result < ApplicationRecord
  has_many :recommendations, dependent: :destroy
  validates :title, presence: true, length: { maximum: 255 }
  validates :description, presence: true, length: { maximum: 65_535 }
  validates :score_range_start, presence: true, numericality: { only_integer: true }
  validates :score_range_end, presence: true, numericality: { only_integer: true }
end
