require 'rails_helper'

RSpec.describe "Sessions", type: :request do
  let(:user) { create(:user) }

  describe "delete /logout" do
    before do
      post login_path, params: { session: {
        email: user.email,
        password: user.password,
      } }
    end

    it 'ログアウト後ログインパスに移る事' do
      delete logout_path
      aggregate_failures do
        expect(response).to redirect_to login_path
        expect(is_logged_in?).to be_falsy
      end
    end
  end
end
