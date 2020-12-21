RSpec.describe "Companies", type: :request do
  let(:company) { create(:company) }
  let(:company_params) { attributes_for(:company) }

  describe "GET /show" do
    it 'リクエストが成功すること' do
      sign_in company
      get company_path(company.id)
      expect(response).to have_http_status(200)
    end

    it "showページが表示されること" do
      sign_in company
      get company_path(company.id)
      expect(response).to render_template :show
    end

    it "企業情報が表示されること" do
      sign_in company
      get company_path(company.id)
      expect(response.body).to include company.company_name
      expect(response.body).to include company.profile
      expect(response.body).to include company.qualification
    end

    context "ログインしていないユーザー" do
      it "トップページへ飛ぶこと" do
        get company_path(company.id)
        expect(response).to render_template :home
      end
    end
  end

  describe "GET /index" do
    it 'リクエストが成功すること' do
      sign_in company
      get users_path
      expect(response).to have_http_status(200)
    end

    it "indexページが表示されること" do
      sign_in company
      get users_path
      expect(response).to render_template :index
    end

    context "ログインしていないユーザー" do
      it "トップページへ飛ぶこと" do
        get users_path
        expect(response).to render_template :home
      end
    end
  end
end
