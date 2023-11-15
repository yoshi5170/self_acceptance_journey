require 'rails_helper'

RSpec.describe 'SelfEsteemTrainingsSpec.rbs', type: :system do
  describe '自己受容トレーニング' do
    let(:user) { create(:user) }
    before do
      login(user)
      visit new_self_esteem_training_path
    end
    context 'フォームの入力が正常' do
      let(:mock_openai_client) { double('OpenAI::Client') }
      let(:mock_response) {
        {
          'choices' => [
            { 'message' => { 'content' => '変換されたポジティブなメッセージ' }}
          ]
        }
      }
      before do
        allow(OpenAI::Client).to receive(:new).and_return(mock_openai_client)
        allow(mock_openai_client).to receive(:chat).and_return(mock_response)
      end
      it '変換が成功する' do
        fill_in 'text', with: '自己否定的な思考'
        click_button '変換'
        sleep 6
        expect(page).to have_text('変換されたポジティブなメッセージ')
        expect(page).to have_current_path(result_self_esteem_trainings_path, ignore_query: true)
      end
    end
    context '1日の使用限度の2回を超えると' do
      let!(:self_esteem_training) { create_list(:self_esteem_training, 2, trained_at: Time.current, user:) }
      it '制限がかかる' do
        fill_in 'text', with: '自己否定的な思考'
        click_button '変換'
        sleep 6
        expect(page).to have_text('1日のトレーニング回数を超えています。')
        expect(page).to have_current_path(root_path)
      end
    end
    context '文字数が50文字以上' do
      it '変換に失敗する' do
        fill_in 'text', with: 't' * 51
        click_button '変換'
        sleep 6
        expect(page).to have_text('50文字以内で入力してください')
      end
    end
  end
end
