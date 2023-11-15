require 'rails_helper'

RSpec.describe PlantedFlower, type: :model do
  let(:user) { create(:user) }
  let(:flower) {create(:flower, :threshold_five) }
  describe 'バリデーション' do
    it 'added_atがある場合、有効である' do
      planted_flower = build(:planted_flower)
      expect(planted_flower).to be_valid
    end
    it 'added_atがない場合、無効である' do
      planted_flower = build(:planted_flower, added_at: '')
      expect(planted_flower).to be_invalid
    end
  end
  describe 'アソシエーション' do
    it 'planted_flowersがuserと関連付いている' do
      planted_flower = create(:planted_flower, user:)
      expect(user.planted_flowers).to include planted_flower
      expect(planted_flower.user_id).to eq(user.id)
    end
    it 'planted_flowersがflowerと関連付いている' do
      planted_flower = create(:planted_flower, flower:)
      expect(flower.planted_flowers).to include planted_flower
      expect(planted_flower.flower_id).to eq(flower.id)
    end
  end
end
