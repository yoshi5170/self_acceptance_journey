class Diary < ApplicationRecord
  belongs_to :user
  has_many :diary_entries, dependent: :destroy
  validates :date, presence: true
  validates :date,
            uniqueness: {
              scope: :user_id,
              message: lambda { |_object, data|
                " #{data[:value]}の日記はすでに作成済みです"
              }
            }
  def self.ransackable_attributes(_auth_object = nil)
    ['created_at']
  end
end
