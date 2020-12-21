RSpec.describe "Users", type: :feature do
  let(:user) { create(:user) }
  let(:user_params) { attributes_for(:user) }

  describe "GET /show" do
    before do
      sign_in user
      visit user_path(user.id)
    end

    it 'リンクまたはボタンが表示されていること' do
      expect(page).to have_link 'matching-ac'
      expect(page).to have_link '企業を探す'
      expect(page).to have_link '試験日程'
      expect(page).to have_button 'アカウント'
      expect(page).to have_link 'マイページ'
      expect(page).to have_link 'アカウント編集'
      expect(page).to have_link 'ログアウト'
      expect(page).to have_link 'フォロー中'
      expect(page).to have_link 'フォロワー'
    end

    it '企業一覧ページへ飛ぶこと' do
      within(".navbar") do
        click_link '企業を探す'
      end
      expect(current_path).to eq companies_path
    end

    it '試験日程ページへ飛ぶこと' do
      within(".navbar") do
        click_link '試験日程'
      end
      expect(current_path).to eq schedule_path
    end

    it 'アカウント関連ページへ飛ぶこと' do
      within(".nav") do
        click_link 'マイページ'
      end
      expect(current_path).to eq user_path(user.id)
      within(".nav") do
        click_link 'アカウント編集'
      end
      expect(current_path).to eq edit_user_registration_path
      within(".nav") do
        click_link 'ログアウト'
      end
      expect(current_path).to eq root_path
    end

    it 'フォロー中ページへ飛ぶこと' do
      within(".stats") do
        click_link 'フォロー中'
      end
      expect(current_path).to eq following_user_path(user.id)
    end

    it 'フォロワーページへ飛ぶこと' do
      within(".stats") do
        click_link 'フォロワー'
      end
      expect(current_path).to eq followers_user_path(user.id)
    end
  end
end
