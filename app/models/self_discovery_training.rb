class SelfDiscoveryTraining < ApplicationRecord
  belongs_to :user
  validates :trained_at, presence: true
end
