class User < ApplicationRecord
  authenticates_with_sorcery!
  has_many :planted_flowers, dependent: :destroy
  validates :name, presence: true
  validates :nickname, presence: true
  validates :uid, presence: true, uniqueness: true

  enum role: { general: 0, admin: 1, guest: 2 }

  def self.from_omniauth(auth)
    find_or_create_by(provider: auth.provider, uid: auth.uid) do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.nickname = auth.info.nickname
      user.name = auth.info.name
    end
  end
end