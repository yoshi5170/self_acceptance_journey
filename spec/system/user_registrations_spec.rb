require 'rails_helper'
RSpec.describe User, type: :system do
  let(:user) { create(:user) }
  let(:other_user) { craete(:user) }

  describe 'User CRUD' do
    describe 'ログイン前' do
      describe 'アカウント登録' do
        context 'フォームの入力値が正常' do
          it 'ユーザーの新規投稿が成功' do
            visit new_user_registration_path
            fill_in 'user_name', with: 'user_01'
            fill_in 'user_email', with: 'test@example.com'
            fill_in 'user_password', with: 'password'
            fill_in 'user_password_confirmation', with: 'password'
            click_button 'アカウント登録'
            expect(page).to have_content 'アカウント登録が完了しました。'
            expect(page).to have_link('マイページ', href: mypage_path, visible: :all)
            expect(current_path).to eq root_path
          end
        end
        context '名前未入力' do
          it 'ユーザーの新規作成が失敗' do
            visit new_user_registration_path
            fill_in 'user_name', with: ''
            fill_in 'user_email', with: 'test@example.com'
            fill_in 'user_password', with: 'password'
            fill_in 'user_password_confirmation', with: 'password'
            click_button 'アカウント登録'
            expect(page).to have_content '名前を入力してください'
            expect(current_path).to eq new_user_registration_path
          end
        end
        context '名前が255文字以上' do
          it 'ユーザーのアカウント作成が失敗' do
            visit new_user_registration_path
            fill_in 'user_name', with: 'u' * 256
            fill_in 'user_email', with: 'test@example.com'
            fill_in 'user_password', with: 'password'
            fill_in 'user_password_confirmation', with: 'password'
            click_button 'アカウント登録'
            expect(page).to have_content '名前は255文字以内で入力してください'
            expect(current_path).to eq new_user_registration_path
          end
        end
        context 'メールアドレス未入力' do
          it 'ユーザーの新規作成が失敗' do
            visit new_user_registration_path
            fill_in 'user_name', with: 'user_01'
            fill_in 'user_email', with: ''
            fill_in 'user_password', with: 'password'
            fill_in 'user_password_confirmation', with: 'password'
            click_button 'アカウント登録'
            expect(page).to have_content 'メールアドレスを入力してください'
            expect(current_path).to eq new_user_registration_path
          end
        end
        context '登録済みメールアドレス' do
          it 'ユーザーの新規作成が失敗' do
            visit new_user_registration_path
            fill_in 'user_name', with: 'user_01'
            fill_in 'user_email', with: user.email
            fill_in 'user_password', with: 'password'
            fill_in 'user_password_confirmation', with: 'password'
            click_button 'アカウント登録'
            expect(page).to have_content 'メールアドレスはすでに存在します'
            expect(current_path).to eq new_user_registration_path
          end
        end
        context 'パスワードとパスワード（確認用）未入力' do
          it 'ユーザーのアカウント作成が失敗' do
            visit new_user_registration_path
            fill_in 'user_name', with: 'user_01'
            fill_in 'user_email', with: 'test@example.com'
            fill_in 'user_password', with: ''
            fill_in 'user_password_confirmation', with: ''
            click_button 'アカウント登録'
            expect(page).to have_content 'パスワードを入力してください'
            expect(current_path).to eq new_user_registration_path
          end
        end
        context 'パスワードの文字数が6文字以下' do
          it 'ユーザーのアカウント作成が失敗' do
            visit new_user_registration_path
            fill_in 'user_name', with: 'user_01'
            fill_in 'user_email', with: 'test@example.com'
            fill_in 'user_password', with: 'p'
            fill_in 'user_password_confirmation', with: 'p'
            click_button 'アカウント登録'
            expect(page).to have_content 'パスワードは6文字以上で入力してください'
            expect(current_path).to eq new_user_registration_path
          end
        end
        context 'パスワードとパスワード確認で入力されたものが不一致' do
          it 'ユーザーのアカウント作成が失敗' do
            visit new_user_registration_path
            fill_in 'user_name', with: 'user_01'
            fill_in 'user_email', with: 'test@example.com'
            fill_in 'user_password', with: 'password'
            fill_in 'user_password_confirmation', with: 'passwordd'
            click_button 'アカウント登録'
            expect(page).to have_content 'パスワード（確認用）とパスワードの入力が一致しません'
            expect(current_path).to eq new_user_registration_path
          end
        end
      end
    end
  end
end
