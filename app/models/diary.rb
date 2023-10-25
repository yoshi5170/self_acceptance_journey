class Diary < ApplicationRecord
  belongs_to :user
  has_many :diary_entries, dependent: :destroy
  validates :date,
    uniqueness: { scope: :user_id,
      message: ->(object, data) do
        " #{data[:value].to_date}の日記はすでに作成済みです"
      end
    }

end
