RSpec.describe "devise_companies", type: :request do
  let(:company) { create(:company) }
  let(:invalid_company) { attributes_for(:company, email: "", password: "") }
  let(:company_params) { attributes_for(:company) }
  let(:invalid_company_params) { attributes_for(:company, company_name: "") }

  describe 'Registrations' do
    context 'パラメータが妥当な場合' do
      it 'リクエストが成功すること' do
        post company_registration_path, params: { company: company_params }
        expect(response.status).to eq 302
      end

      it 'createが成功すること' do
        expect do
          post company_registration_path, params: { company: company_params }
        end.to change(Company, :count).by 1
      end

      it 'リダイレクトされること' do
        post company_registration_path, params: { company: company_params }
        expect(response).to redirect_to company_path(Company.last)
      end
    end

    context 'パラメータが不正な場合' do
      it 'リクエストが成功すること' do
        post company_registration_path, params: { company: invalid_company_params }
        expect(response.status).to eq 200
      end

      it 'createが失敗すること' do
        expect do
          post company_registration_path, params: { company: invalid_company_params }
        end.not_to change(Company, :count)
      end

      it 'エラーが表示されること' do
        post company_registration_path, params: { company: invalid_company_params }
        expect(response.body).to include '企業名を入力してください'
      end
    end
  end

  describe 'Sessions' do
    context '正常にログイン＆ログアウト' do
      it "ログイン&ログアウト" do
        sign_in company
        get company_path(company.id)
        expect(response).to be_success
        expect(response).to have_http_status(200)
        delete destroy_company_session_path
        expect(response).to have_http_status(302)
        expect(session[:company_id]).to be_falsey
      end
    end

    context "ログインに失敗した時" do
      it "エラーメッセージが表示されていること" do
        pending
        get new_company_session_path
        expect(response).to have_http_status(:success)
        sign_in invalid_company
        expect(response).to have_http_status(:success)
        get company_path(company.id)
      end
    end
  end
end
