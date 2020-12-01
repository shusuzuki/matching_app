RSpec.describe "StaticPages", type: :feature do
  describe "GET /home" do
    before do
      visit root_path
    end

    it 'リンクが表示されていること' do
      expect(page).to have_link 'matching-ac'
      expect(page).to have_link 'ログイン'
      expect(page).to have_link '新規登録'
      find('.home-icon').click
    end

    it 'タイトルリンクからトップページへ戻ること' do
      within(".navbar-header") do
        click_link 'matching-ac'
      end
      expect(current_path).to eq root_path
    end

    it 'ホームアイコンからトップページへ戻ること' do
      within(".nav") do
        find('.home-icon').click
      end
      expect(current_path).to eq root_path
    end

    it 'ページ内に特定の文字列が表示されていること' do
      expect(page).to have_content '人と社会をつなげる新しい未来の電気づくり'
      expect(page).to have_content 'MATCHING-AC'
      expect(page).to have_content '私達の生活に欠かせないエネルギーとなる電気ですが'
    end
  end
end
