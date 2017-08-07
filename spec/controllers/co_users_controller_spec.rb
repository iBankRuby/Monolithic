require 'rails_helper'

RSpec.describe CoUsersController, type: :controller do
  let!(:user) { create :user }
  let(:account) { create :account }
  before { sign_in user }

  describe 'GET show' do
    it 'has a 200 status code' do
      get :show, params: { account_id: account.id, id: user.id  }
      expect(response).to have_http_status :ok
    end

    it 'render index template' do
      get :show, params: { account_id: account.id, id: user.id }
      expect(response).to render_template :show
    end
  end
end
