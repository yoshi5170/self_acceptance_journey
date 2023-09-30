class UnlockableFlower < ApplicationRecord
  has_many :planted_flowers, dependent: :restrict_with_error
  has_one_attached :flower_image
end
