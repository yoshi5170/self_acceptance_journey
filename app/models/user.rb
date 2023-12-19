class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable
  enum role: { general: 0, guest: 1, admin: 2 }
  has_many :planted_flowers, dependent: :destroy
  has_many :diaries, dependent: :destroy
  has_many :self_esteem_trainings, dependent: :destroy
  has_many :self_discovery_trainings, dependent: :destroy
  has_many :encouragement_requests, dependent: :destroy

  validates :name, presence: true, length: { maximum: 255 }

  def add_training_and_flower
    ActiveRecord::Base.transaction do
      self_esteem_trainings.create!(trained_at: Time.current)
      flower_to_add = Flower.find_flower(self_esteem_trainings.count)
      planted_flowers.create!(flower: flower_to_add, added_at: Time.current) if flower_to_add
    end
  rescue ActiveRecord::RecordInvalid
    false
  end

  def own?(object)
    object.user_id == id
  end
end
