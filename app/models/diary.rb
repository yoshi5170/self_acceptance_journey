class Diary < ApplicationRecord
  belongs_to :user
  has_many :diary_entries, dependent: :destroy
  validates :date,
            uniqueness: {
              scope: :user_id,
              message: lambda { |_object, data|
                " #{data[:value]}の日記はすでに作成済みです"
              }
            }
end
