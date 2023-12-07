class Flower < ApplicationRecord
  has_many :planted_flowers, dependent: :restrict_with_error
  has_one_attached :flower_image

  validates :name, presence: true, length: { maximum: 255 }
  validates :threshold, presence: true, numericality: { only_integer: true }
  validates :flower_image, presence: true, blob: { content_type: ['image/png']}

  def self.find_flower(total_trainings)
    return nil if total_trainings.zero?

    # flowersをthresholdの昇順で取得
    # 例）[花A: threshold 10,　花B: threshold 35, 花C: threshold 65, 花D: threshold 100, 花E: threshold 145, 花F: threshold 195]
    flowers = order(threshold: :asc)

    # total_trainings（トータルのトレーニング回数）がflower.threshold（各花が解禁されるためのトレーニング完了回数の閾値）以下であるかどうかを判断
    flowers.find { |flower| total_trainings <= flower.threshold }
  end
end
