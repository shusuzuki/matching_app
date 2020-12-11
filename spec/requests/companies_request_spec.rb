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
      expect(response.body).to include company.qualification.join("/")
    end
  end
end
