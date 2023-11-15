require 'rails_helper'

RSpec.describe SelfEsteemTraining, type: :model do
  let(:user) { create(:user) }
  describe 'バリデーション' do
    it 'trained_atがある場合、有効である' do
      self_esteem_training = build(:self_esteem_training)
      expect(self_esteem_training).to be_valid
    end
    it 'trained_atがない場合、無効である' do
      self_esteem_training = build(:self_esteem_training, trained_at: '')
      expect(self_esteem_training).to be_invalid
    end
  end
  describe 'アソシエーション' do
    it 'self_esteem_trainingsがuserと関連付いている' do
      self_esteem_training = create(:self_esteem_training, user:)
      expect(user.self_esteem_trainings).to include self_esteem_training
      expect(self_esteem_training.user_id).to eq(user.id)
    end
  end
end
