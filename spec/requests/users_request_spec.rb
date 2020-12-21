RSpec.describe "Users", type: :request do
  let(:user) { create(:user) }
  let(:user_params) { attributes_for(:user) }
  let(:company) { create(:company) }
  let(:company_params) { attributes_for(:company) }

  describe "GET /show" do
    it 'リクエストが成功すること' do
      sign_in user
      get user_path(user.id)
      expect(response).to have_http_status(200)
    end

    it "showページが表示されること" do
      sign_in user
      get user_path(user.id)
      expect(response).to render_template :show
    end

    it "ユーザー情報が表示されること" do
      sign_in user
      get user_path(user.id)
      expect(response.body).to include user.name
      expect(response.body).to include user.profile
      expect(response.body).to include user.qualification
      expect(response.body).to include user.sex
    end

    context "ログインしていないユーザー" do
      it "トップページへ飛ぶこと" do
        get user_path(user.id)
        expect(response).to render_template :home
      end
    end
  end

  describe "GET /index" do
    it 'リクエストが成功すること' do
      sign_in user
      get companies_path
      expect(response).to have_http_status(200)
    end

    it "indexページが表示されること" do
      sign_in user
      get companies_path
      expect(response).to render_template :index
    end

    context "ログインしていないユーザー" do
      it "トップページへ飛ぶこと" do
        get companies_path
        expect(response).to render_template :home
      end
    end
  end
end
