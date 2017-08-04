require 'rails_helper'

RSpec.describe LimitsController, type: :controller do
  let(:co_user) { create(:user, email: 'me3@mail.by') }
  let(:account) { create(:account) }
  let(:limit) { create(:limit) }
  let(:role) { create(:role, id: 2, name: 'co-user') }
  let(:usr_acc) { create(:account_user,
                         user_id: co_user.id,
                         account_id: account.id,
                         limit_id: limit.id,
                         role_id: role.id) }

  before { sign_in co_user }

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

  describe 'GET show' do
    it 'has a 200 status code' do
      get :show, params: { id: co_user.id }
      expect(response).to have_http_status :ok
    end

    it 'render show template' do
      get :show, params: { id: co_user.id }
      expect(response).to render_template :show
    end
  end
end
