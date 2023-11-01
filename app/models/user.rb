class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
          :recoverable, :rememberable, :validatable
  enum role: {general: 0, guest: 1, admin: 2}
  has_many :planted_flowers, dependent: :destroy
  has_many :diaries, dependent: :destroy
  has_many :self_esteem_trainings, dependent: :destroy

  def add_training_and_flower
    ActiveRecord::Base.transaction do
      self_esteem_trainings.create(trained_at: Time.current)
      flower_to_add = UnlockableFlower.find_flower(self_esteem_trainings.count)
      planted_flowers.create(unlockable_flower: flower_to_add, added_at: Time.current) if flower_to_add
    end
  rescue ActiveRecord::RecordInvalid
    false
  end
end
