require 'rails_helper'

RSpec.describe ManagementController, type: :controller do
  let!(:user) { create :user }
  let(:account) { create :account }
  let!(:usr_acc) { create(:account_user,
                          user_id: user.id,
                          account_id: account.id,
                          role_id: 1)
  }
  before { sign_in user }

  describe 'GET index' do
    it 'has a 200 status code' do
      get :index, params: { account_id: account.id }
      expect(response).to have_http_status :ok
    end

    it 'render index template' do
      get :index, params: { account_id: account.id }
      expect(response).to render_template :index
    end
  end

  describe 'DELETE destroy' do
    it 'has a 302 status code' do
      delete :destroy, params: { account_id: account.id, id: usr_acc.id }
      expect(response).to have_http_status :found
    end

    it 'render index template' do
      delete :destroy, params: { account_id: account.id, id: usr_acc.id }
      expect(response).to redirect_to account_management_index_path
    end
  end
end