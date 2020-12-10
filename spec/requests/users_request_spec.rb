RSpec.describe "Users", type: :request do
  let(:user) { create(:user) }
  let(:user_params) { attributes_for(:user) }

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
  end
end