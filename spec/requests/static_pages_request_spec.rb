RSpec.describe "StaticPages_request", type: :request do
  before do
    get root_path
  end

  describe "GET /home" do
    it "リクエストが成功すること" do
      expect(response).to have_http_status(200)
    end

    it 'homeページが表示されること' do
      expect(response).to render_template :home
    end
  end
end
