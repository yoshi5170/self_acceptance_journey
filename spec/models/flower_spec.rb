require 'rails_helper'

RSpec.describe Flower, type: :model do
  let(:user) { create(:user) }
  describe 'バリデーション' do
    it '名前がある場合、有効である' do
      flower = build(:flower)
      expect(flower).to be_valid
    end
    it '名前がない場合、無効である' do
      flower = build(:flower, name: '')
      expect(flower).to be_invalid
    end
    it 'しきい値がある場合、有効である' do
      flower = build(:flower)
      expect(flower).to be_valid
    end
    it 'しきい値がない場合、無効である' do
      flower = build(:flower, threshold: '')
      expect(flower).to be_invalid
    end
  end
  describe 'アソシエーション' do
    let(:flower_01) { create(:flower, :threshold_five) }
    it '子要素(planted_flowers)がある場合親要素(flower)を削除することができない' do
      create(:planted_flower, user:, flower: flower_01)
      expect { flower_01.destroy }.not_to change(Flower, :count)
      expect(flower_01.errors).not_to be_empty
    end
  end
  describe '.find_flower' do
    let!(:flower_01) { create(:flower, :threshold_five) }
    let!(:flower_02) { create(:flower, :threshold_ten) }
    let!(:flower_03) { create(:flower, :threshold_twofive) }
    let!(:flower_04) { create(:flower, :threshold_fifty) }
    context 'total_trainingsがゼロの場合' do
      it 'returns nil' do
        expect(Flower.find_flower(0)).to be_nil
      end
    end
    context 'total_trainingsが閾値の間の場合' do
      it 'total_trainings以上の閾値を持つ最初の花を返す' do
        expect(Flower.find_flower(3)).to eq(flower_01)
        expect(Flower.find_flower(6)).to eq(flower_02)
      end
    end
    context 'total_trainingsと閾値が等しい場合' do
      it 'その閾値を持つ花を返す' do
        expect(Flower.find_flower(25)).to eq(flower_03)
        expect(Flower.find_flower(50)).to eq(flower_04)
      end
    end
  end
end
