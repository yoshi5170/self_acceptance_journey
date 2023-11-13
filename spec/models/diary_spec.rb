require 'rails_helper'

RSpec.describe Diary, type: :model do
  let(:user) { create(:user) }
  describe 'バリデーション' do
    it '日付がある場合、有効である' do
      diary = build(:diary)
      expect(diary).to be_valid
    end
    it '日付がない場合、無効である' do
      diary = build(:diary, date: '')
      diary.valid?
      expect(diary).to be_invalid
    end
    it '同じユーザーと日付の組み合わせが存在する場合、無効である' do
      first_diary = create(:diary, user:, date: Date.current)
      second_diary = build(:diary, user:, date: first_diary.date)
      second_diary.valid?
      expect(second_diary.errors[:date]).to include(" #{first_diary.date}の日記はすでに作成済みです")
    end
  end
  describe 'アソシエーション' do
    it 'diariesがuserと関連付いている' do
      diary = create(:diary, user:)
      expect(user.diaries).to include diary
      expect(diary.user_id).to eq(user.id)
    end

    it '日記が削除されたとき、関連する日記エントリも削除される' do
      diary = create(:diary, user:)
      create_list(:diary_entry, 3, diary:)

      expect { diary.destroy }.to change(DiaryEntry, :count).by(-3)
    end
  end
end
