require 'rails_helper'

RSpec.describe AccountsController, type: :controller do
  let!(:user) { create :user }
  let(:account) { create :account }
  let!(:account_user) { create(:account_user,
                          user_id: user.id,
                          account_id: account.id,
                          role_id: 2) }
  before { sign_in user }

  describe 'GET index' do
    it 'has a 200 status code' do
      get :index
      expect(response).to have_http_status :ok
    end

    it 'render index template' do
      get :index
      expect(response).to render_template :index
    end
  end

  describe 'GET new' do
    it 'has a 200 status code' do
      get :new
      expect(response).to have_http_status :ok
    end

    it 'render new template' do
      get :new
      expect(response).to render_template :new
    end
  end

  describe 'GET show' do
    it 'has a 200 status code' do
      get :show, params: { id: account.hash_id }
      expect(response).to have_http_status :ok
    end

    it 'render show template' do
      get :show, params: { id: account.hash_id }
      expect(response).to render_template :show
    end
  end

  describe 'POST create' do
    it 'redirect to account' do
      post :create, params: { account: account }
      expect(response).to redirect_to Account.last
    end

    it 'creates a new account' do
      post :create, params: { account: account }
      expect(Account.exists?(account.id)).to be_truthy
    end
  end

  describe 'PATCH update' do
    it 'restores account' do
      delete :destroy, params: { id: account.id }
      patch :update, params: { id: account.id }
      expect(Account.exists?(account.id)).to be_truthy
    end
  end

  describe 'DELETE destroy' do
    it 'redirect to users' do
      delete :destroy, params: { id: account }
      expect(response).to redirect_to accounts_url
    end

    it 'remove account from db' do
      delete :destroy, params: { id: account }
      expect(Account.exists?(account.id)).to be_falsey
    end
  end

end
