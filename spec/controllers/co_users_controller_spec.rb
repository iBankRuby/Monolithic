require 'rails_helper'

RSpec.describe CoUsersController, type: :controller do
  let!(:user) { create :user }
  let(:account) { create :account }
  let(:rule) { create(:rule, spending_limit: 0.0)}
  let(:limit) { create(:limit, reminder: rule.spending_limit) }
  let!(:usr_acc) { create(:account_user,
                          user_id: user.id,
                          account_id: account.id,
                          limit_id: limit.id,
                          rule_id: rule.id,
                          role_id: 2)
  }
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

  describe 'PATCH update' do
    it 'has a 302 status code' do
      patch :update, params: { account_id: account.id, id: user.id, account_rule: { spending_limit: 20} }
      expect(response).to have_http_status :found
    end

    it 'render index template' do
      patch :update, params: { account_id: account.id, id: user.id, account_rule: { spending_limit: 20} }
      expect(response).to redirect_to :account_co_user
    end
  end
end
