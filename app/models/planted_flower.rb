class PlantedFlower < ApplicationRecord
  belongs_to :user
  belongs_to :unlockable_flower
end