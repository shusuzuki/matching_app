RSpec.describe "Qualifications", type: :request do
  let(:user) { create(:user) }

  before do
    sign_in user
    get schedule_path
  end

  describe "GET /schedule" do
    it "リクエストが成功すること" do
      expect(response).to have_http_status(200)
    end

    it 'scheduleページが表示されること' do
      expect(response).to render_template :schedule
    end
  end
end
