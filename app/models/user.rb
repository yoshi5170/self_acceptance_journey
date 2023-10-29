class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
          :recoverable, :rememberable, :validatable
  enum role: {general: 0, guest: 1, admin: 2}
  has_many :planted_flowers, dependent: :destroy
  has_many :diaries, dependent: :destroy
end
