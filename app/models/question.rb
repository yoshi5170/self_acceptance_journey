class Question < ApplicationRecord
  validates :text, presence: true, length: { maximum: 255 }
  validates :score_type, presence: true, numericality: { only_integer: true }
  enum score_type: { down: 0, up: 1 }

  SCORES = {
    down: {
      "とても当てはまる" => 3,
      "まあまあ当てはまる" => 2,
      "あまり当てはまらない" => 1,
      "全く当てはまらない" => 0
    },
    up: {
      "とても当てはまる" => 0,
      "まあまあ当てはまる" => 1,
      "あまり当てはまらない" => 2,
      "全く当てはまらない" => 3
    }
  }

  def scores_for_role
    SCORES[score_type.to_sym]
  end
end