require 'rails_helper'

RSpec.describe DiaryEntry, type: :model do
  let(:diary) { create(:diary) }
  describe 'バリデーション' do
    it 'contentがある場合、有効' do
      diary_entry = build(:diary_entry)
      expect(diary_entry).to be_valid
    end
    it 'contentがない場合、無効' do
      diary_entry = build(:diary_entry, content: '')
      expect(diary_entry).to be_invalid
    end
  end
  describe 'アソシエーション' do
    it 'diary_enyriesがdiaryと関連付いている' do
      diary_entry = create(:diary_entry, diary:)
      expect(diary.diary_entries).to include diary_entry
      expect(diary_entry.diary_id).to eq(diary.id)
    end
  end
end