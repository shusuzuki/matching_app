RSpec.describe "StaticPages", type: :feature do
  describe "GET /home" do
    before do
      visit root_path
    end

    it 'タイトルリンクからトップページへ戻ること' do
      within(".navbar-header") do
        click_link 'matching-ac'
      end
      expect(current_path).to eq root_path
    end
  end
end
