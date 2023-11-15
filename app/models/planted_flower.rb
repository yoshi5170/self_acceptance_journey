class PlantedFlower < ApplicationRecord
  belongs_to :user
  belongs_to :flower
  validates :added_at, presence: true
end
