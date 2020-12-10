RSpec.describe "devise_users", type: :request do
  let(:user) { create(:user) }
  let(:user_params) { attributes_for(:user) }
  let(:invalid_user_params) { attributes_for(:user, name: "") }

  describe 'Registrations' do
    context 'パラメータが妥当な場合' do
      it 'リクエストが成功すること' do
        post user_registration_path, params: { user: user_params }
        expect(response.status).to eq 302
      end

      it 'createが成功すること' do
        expect do
          post user_registration_path, params: { user: user_params }
        end.to change(User, :count).by 1
      end

      it 'リダイレクトされること' do
        post user_registration_path, params: { user: user_params }
        expect(response).to redirect_to user_path(User.last)
      end
    end

    context 'パラメータが不正な場合' do
      it 'リクエストが成功すること' do
        post user_registration_path, params: { user: invalid_user_params }
        expect(response.status).to eq 200
      end

      it 'createが失敗すること' do
        expect do
          post user_registration_path, params: { user: invalid_user_params }
        end.not_to change(User, :count)
      end

      it 'エラーが表示されること' do
        post user_registration_path, params: { user: invalid_user_params }
        expect(response.body).to include '名前を入力してください'
      end
    end
  end

  describe 'Sessions' do
    context '正常にログイン＆ログアウト' do
      it "ログイン&ログアウト" do
        sign_in user
        get user_path(user.id)
        expect(response).to be_success
        expect(response).to have_http_status(200)
        delete destroy_user_session_path
        expect(response).to have_http_status(302)
        expect(session[:user_id]).to be_falsey
      end
    end

    context "ログインに失敗した時" do
      it "エラーメッセージが表示されていること" do
        pending
        get new_user_session_path
        expect(response).to have_http_status(:success)
        sign_in invalid_user
        expect(response).to have_http_status(:success)
        get user_path(company.id)
      end
    end
  end
end
