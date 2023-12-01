require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'バリデーション' do
    it '名前、メール、パスワードがある場合、有効である' do
      user = build(:user)
      expect(user).to be_valid
    end
    it '名前がない場合、無効である' do
      user = build(:user, name: '')
      user.valid?
      expect(user.errors[:name]).to include('を入力してください')
    end
    it '名前が255文字以上場合、無効である' do
      user = build(:user, name: 'n' * 256)
      user.valid?
      expect(user.errors[:name]).to include('は255文字以内で入力してください')
    end
    it 'メールアドレスがない場合、無効である' do
      user = build(:user, email: '')
      user.valid?
      expect(user.errors[:email]).to include('を入力してください')
    end
    it '重複したメールアドレスの場合、無効である' do
      other_user = create(:user)
      user = build(:user, email: other_user.email)
      user.valid?
      expect(user.errors[:email]).to include('はすでに存在します')
    end
    it 'パスワードがない場合、無効である' do
      user = build(:user, password: '')
      user.valid?
      expect(user.errors[:password]).to include('を入力してください')
    end
    it 'パスワード(確認用）がない場合、無効である' do
      user = build(:user, password_confirmation: '')
      user.valid?
      expect(user.errors[:password_confirmation]).to include('とパスワードの入力が一致しません')
    end
    it 'パスワードが6文字未満の場合、無効である' do
      user = build(:user, password: 'p')
      user.valid?
      expect(user.errors[:password]).to include('は6文字以上で入力してください')
    end
  end

  describe 'アソシエーション' do
    let(:user) { create(:user) }

    it 'planted_flowersがuserと関連付いている' do
      planted_flower = create(:planted_flower, user:)
      expect(user.planted_flowers).to include planted_flower
      expect(planted_flower.user_id).to eq(user.id)
    end
    it 'diariesがuserと関連付いている' do
      diary = create(:diary, user:)
      expect(user.diaries).to include diary
      expect(diary.user_id).to eq(user.id)

    end
    it 'self_esteem_trainingsがuserと関連付いている' do
      self_esteem_training = create(:self_esteem_training, user:)
      expect(user.self_esteem_trainings).to include self_esteem_training
      expect(self_esteem_training.user_id).to eq(user.id)
    end
  end

  describe 'add_training_and_flower' do
    let(:user) { create(:user) }
    let!(:flower_a) { create(:flower, threshold: 10) }
    let!(:flower_b) { create(:flower, threshold: 35) }
    context '正常にレコードが作成される場合' do
      it '自尊心トレーニングと花のレコードを作成する' do
        expect { user.add_training_and_flower }.to change { user.self_esteem_trainings.count }.by(1).and change { user.planted_flowers.count }.by(1)
      end
    end

    context '例外が発生する場合' do
      before do
        allow(user.self_esteem_trainings).to receive(:create!).and_raise(ActiveRecord::RecordInvalid)
      end
      it '例外を正しく処理する' do
        expect(user.add_training_and_flower).to be false
      end
      it 'トランザクションがロールバックされる' do
        expect { user.add_training_and_flower }.to change { SelfEsteemTraining.count }.by(0)
      end
    end
  end
end
