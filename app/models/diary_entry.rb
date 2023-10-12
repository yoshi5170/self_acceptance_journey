class DiaryEntry < ApplicationRecord
  belongs_to :diary
  validates :content, presence: true
end
