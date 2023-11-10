require 'rails_helper'
RSpec.describe User, type: :system do
  let(:user) { create(:user)}

  describe 'ログイン' do
    describe 'ログイン前' do
      context 'フォームの入力値が正常' do
        it 'ユーザーのログインが成功' do
          visit new_user_session_path
          fill_in 'user_email', with: user.email
          fill_in 'user_password', with: user.password
          click_button 'ログイン'
          expect(page).to have_content 'ログインしました。'
          expect(page).to have_link('マイページ', href: mypage_path, visible: :all)
          expect(current_path).to eq root_path
        end
      end
      context 'メールアドレス未入力' do
        it 'ユーザーのログインが失敗' do
          visit new_user_session_path
          fill_in 'user_email', with: ''
          fill_in 'user_password', with: user.password
          click_button 'ログイン'
          expect(page).to have_content 'メールアドレスまたはパスワードが違います。'
          expect(current_path).to eq new_user_session_path
        end
      end
      context 'password未入力' do
        it 'ユーザーのログインが失敗' do
          visit new_user_session_path
          fill_in 'user_email', with: user.email
          fill_in 'user_password', with: ''
          click_button 'ログイン'
          expect(page).to have_content 'メールアドレスまたはパスワードが違います。'
          expect(current_path).to eq new_user_session_path
        end
      end
    end
  end
end