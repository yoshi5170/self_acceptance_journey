require 'rails_helper'

RSpec.describe 'Gardens', type: :system do
  let(:user) { create(:user) }
  let!(:flower_01) { create(:flower, :threshold_five) }
  let!(:flower_02) { create(:flower, :threshold_ten) }
  let(:mock_openai_client) { double('OpenAI::Client') }
  let(:mock_response) {
    {
      'choices' => [
        { 'message' => { 'content' => '変換されたポジティブなメッセージ' } }
      ]
    }
  }
  # let(:planted_flower) { create(:planted_flower, user:) }
  before do
    login(user)
    visit new_self_esteem_training_path
    allow(OpenAI::Client).to receive(:new).and_return(mock_openai_client)
    allow(mock_openai_client).to receive(:chat).and_return(mock_response)
  end
  describe 'ガーデン' do
    context 'トレーニング回数が５回以下の場合' do
      it 'flower01.png画像が表示される' do
        sleep 6
        fill_in 'text', with: '自己否定的な思考'
        click_button '変換'
        sleep 6
        expect(page).to have_text('変換されたポジティブなメッセージ')
        expect(page).to have_current_path(result_self_esteem_trainings_path, ignore_query: true)
        visit garden_path
        expect(page).to have_selector("img[src$='flower01.png']")
      end
    end
    context 'トレーニング回数が10回以下の場合' do
      let!(:self_esteem_training) { create_list(:self_esteem_training, 5, trained_at: Time.current.prev_day(1), user:) }
      it 'flower02.png画像が表示される' do
        fill_in 'text', with: '自己否定的な思考'
        click_button '変換'
        sleep 6
        expect(page).to have_text('変換されたポジティブなメッセージ')
        expect(page).to have_current_path(result_self_esteem_trainings_path, ignore_query: true)
        visit garden_path
        expect(page).to have_selector("img[src$='flower02.png']")
      end
    end
  end
end
