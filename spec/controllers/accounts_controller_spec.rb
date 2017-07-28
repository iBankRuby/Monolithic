require 'rails_helper'

RSpec.describe AccountsController, type: :controller do
  before do
    @user = FactoryGirl.create :user
    sign_in @user
  end

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
    before :each do
      @account = FactoryGirl.create :account
    end

    it 'has a 200 status code' do
      get :show, params: { id: @account.id }
      expect(response).to have_http_status :ok
    end

    it 'render show template' do
      get :show, params: { id: @account.id }
      expect(response).to render_template :show
    end
  end

  describe 'POST create' do
    before :each do
      @account = FactoryGirl.create :account
    end

    it 'redirect to account' do
      post :create, params: { account: @account }
      expect(response).to redirect_to Account.last
    end

    it 'creates a new account' do
      post :create, params: { account: @account }
      expect(Account.exists?(@account.id)).to be_truthy
    end
  end

  describe 'DELETE destroy' do
    before :each do
      @account = FactoryGirl.create :account
    end

    it 'redirect to users' do
      delete :destroy, params: { id: @account }
      expect(response).to redirect_to accounts_url
    end

    it 'remove user from db' do
      delete :destroy, params: { id: @account }
      expect(Account.exists?(@account.id)).to be_falsey
    end
  end
end
