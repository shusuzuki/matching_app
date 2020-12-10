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
  end
end
