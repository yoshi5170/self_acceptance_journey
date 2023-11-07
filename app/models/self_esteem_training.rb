class SelfEsteemTraining < ApplicationRecord
  belongs_to :user
  validates :trained_at, presence: true
end
