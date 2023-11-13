require 'rails_helper'

RSpec.describe 'Diaries', type: :system do
  describe 'Diary' do
    describe '日記一覧' do
      let(:user_a) { create(:user) }
      let(:user_b) { create(:user) }
      let!(:diary_a) { create(:diary, user: user_a)}
      let!(:diary_entries_a) { create_list(:diary_entry, 3, diary: diary_a)}

      context 'ユーザーAがログインしている時' do
        before do
          login(user_a)
          visit diaries_path
        end
        it 'ユーザーAが作成した日記が表示される' do
          diary_entries_a.each do |entry|
            expect(page).to have_content(entry.content)
          end
        end
      end
      context 'ユーザーBがログインしている時' do
        before do
          login(user_b)
          visit diaries_path
        end
        it 'ユーザーAが作成した日記が表示されない' do
          diary_entries_a.each do |entry|
            expect(page).not_to have_content(entry.content)
          end
        end
      end
    end

    describe '日記詳細' do
      let(:user_a) { create(:user) }
      let(:user_b) { create(:user) }
      let!(:diary_a) { create(:diary, user: user_a)}
      let!(:diary_entries_a) { create_list(:diary_entry, 3, diary: diary_a) }
      context 'ユーザーAがログインしている時' do
        before do
          login(user_a)
          visit diary_path(diary_a)
        end
        it 'ユーザーAが作成した日記が表示される' do
          diary_entries_a.each do |entry|
            expect(page).to have_content(entry.content)
          end
        end
      end
    end

    describe '日記作成' do
      let(:user_a) { create(:user) }
      context 'フォームの入力値が正常' do
        before do
          login(user_a)
          visit new_diary_path
        end
        it '日記作成が成功' do
          fill_in 'diary_form_entries_contents_0', with: '良かったこと1'
          fill_in 'diary_form_entries_contents_1', with: '良かったこと2'
          fill_in 'diary_form_entries_contents_2', with: '良かったこと3'
          click_button '登録する'
          expect(page).to have_content '日記が作成されました'
          expect(page).to have_content '良かったこと1'
          expect(page).to have_content '良かったこと2'
          expect(page).to have_content '良かったこと3'
        end
      end
      context 'フォームの未入力' do
        before do
          login(user_a)
          visit new_diary_path
        end
        it '日記作成が失敗' do
          fill_in 'diary_form_entries_contents_0', with: ''
          fill_in 'diary_form_entries_contents_1', with: ''
          fill_in 'diary_form_entries_contents_2', with: ''
          click_button '登録する'
          expect(page).to have_content 'すべてのフォームに入力してください'
          expect(page).to have_content '日記作成に失敗しました'
        end
      end
      context '今日の日記が既に作成済み' do
        let!(:diary_a) { create(:diary, user: user_a, date: Date.current) }
        let!(:diary_entries_a) { create_list(:diary_entry, 3, diary: diary_a) }
        before do
          login(user_a)
          visit new_diary_path
        end
        it '日記作成が失敗' do
          fill_in 'diary_form_entries_contents_0', with: '良かったこと1'
          fill_in 'diary_form_entries_contents_1', with: '良かったこと2'
          fill_in 'diary_form_entries_contents_2', with: '良かったこと3'
          click_button '登録する'
          expect(page).to have_content "日付 #{Date.current}の日記はすでに作成済みです"
          expect(page).to have_content '日記作成に失敗しました'
        end
      end
    end

    describe '日記編集' do
      let(:user_a) { create(:user) }
      let!(:diary_a) { create(:diary, user: user_a, date: Date.current) }
      let!(:diary_entries_a) { create_list(:diary_entry, 3, diary: diary_a) }
      before do
        login(user_a)
        visit edit_diary_path(diary_a)
      end
      context 'フォームの入力値が正常' do
        it '日記編集が成功' do
          fill_in 'diary_form_entries_contents_0', with: '良かったこと1'
          fill_in 'diary_form_entries_contents_1', with: '良かったこと2'
          fill_in 'diary_form_entries_contents_2', with: '良かったこと3'
          click_button '編集する'
          expect(page).to have_content '日記を編集しました'
          expect(current_path).to eq diary_path(diary_a)
        end
      end
      context 'フォームの未入力' do
        it '日記編集が失敗' do
          fill_in 'diary_form_entries_contents_0', with: ''
          fill_in 'diary_form_entries_contents_1', with: ''
          fill_in 'diary_form_entries_contents_2', with: ''
          click_button '編集する'
          expect(page).to have_content 'すべてのフォームに入力してください'
          expect(page).to have_content '日記の編集に失敗しました'
        end
      end
    end

    describe '日記削除' do
      let(:user_a) { create(:user) }
      let!(:diary_a) { create(:diary, user: user_a) }
      let!(:diary_entries_a) { create_list(:diary_entry, 3, diary: diary_a) }
      before do
        login(user_a)
        visit diary_path(diary_a)
      end
      it '日記の削除成功' do
        expect do
          click_link '削除'
          page.accept_confirm '日記を削除しますか?'
          sleep 0.5
        end.to change(user_a.diaries, :count).by(-1)
        expect(page).to have_content '日記を削除しました'
        expect(current_path).to eq diaries_path
      end
    end
  end
end
