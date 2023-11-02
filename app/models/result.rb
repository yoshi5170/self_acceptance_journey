class Result < ApplicationRecord
  has_many :recommendations, dependent: :destroy
end
