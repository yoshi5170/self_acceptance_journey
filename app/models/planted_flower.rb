class PlantedFlower < ApplicationRecord
  belongs_to :user
  belongs_to :flower
end
