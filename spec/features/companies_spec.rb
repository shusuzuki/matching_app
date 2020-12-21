RSpec.describe "Companies", type: :feature do
  let(:company) { create(:company) }
  let(:company_params) { attributes_for(:company) }

  describe "GET /show" do
    before do
      sign_in company
      visit company_path(company.id)
    end

    it 'リンクまたはボタンが表示されていること' do
      expect(page).to have_link 'matching-ac'
      expect(page).to have_link '電気工事士を探す'
      expect(page).to have_button 'アカウント'
      expect(page).to have_link 'マイページ'
      expect(page).to have_link 'アカウント編集'
      expect(page).to have_link 'ログアウト'
      expect(page).to have_link 'フォロー中'
      expect(page).to have_link 'フォロワー'
    end

    it '電気工事士一覧ページへ飛ぶこと' do
      within(".navbar") do
        click_link '電気工事士を探す'
      end
      expect(current_path).to eq users_path
    end

    it 'アカウント関連ページへ飛ぶこと' do
      within(".nav") do
        click_link 'マイページ'
      end
      expect(current_path).to eq company_path(company.id)
      within(".nav") do
        click_link 'アカウント編集'
      end
      expect(current_path).to eq edit_company_registration_path
      within(".nav") do
        click_link 'ログアウト'
      end
      expect(current_path).to eq root_path
    end

    it 'フォロー中ページへ飛ぶこと' do
      within(".stats") do
        click_link 'フォロー中'
      end
      expect(current_path).to eq following_company_path(company.id)
    end

    it 'フォロワーページへ飛ぶこと' do
      within(".stats") do
        click_link 'フォロワー'
      end
      expect(current_path).to eq followers_company_path(company.id)
    end
  end
end
