require 'rails_helper'

RSpec.describe RulesController, type: :controller do
  let(:user) { create(:user) }
  let(:account) { create(:account) }
  let(:rule) { create(:rule) }

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

  describe 'GET new' do
    it 'has a 200 status code' do
      get :new, params: { account_id: account.id }
      expect(response).to have_http_status :ok
    end

    it 'render new template' do
      get :new, params: { account_id: account.id }
      expect(response).to render_template :new
    end
  end

  describe 'GET edit' do
    it 'has a 200 status code' do
      get :edit, params: { account_id: account.id, id: rule.id }
      expect(response).to have_http_status :ok
    end

    it 'render edit template' do
      get :edit, params: { account_id: account.id, id: rule.id }
      expect(response).to have_http_status :ok
    end
  end

  describe 'POST create' do
    context 'with valid params' do
      it 'creates new rule group' do
        rules_count = Rule.count
        post :create, params: { account_id: account.id, rules: {} }
        expect(Rule.count).to eq(rules_count.next)
      end

      it 'redirect to account rules' do
        post :create, params: { account_id: account.id, rules: {} }
        expect(response).to redirect_to :account_rules
      end
    end
  end

  # describe 'PATCH update' do
  #   context 'with valid params' do
  #     it 'updates rule group' do
  #       patch :update, params: { account_id: account.id, id: rule.id, rules: {} }
  #       expect(rule.updated_at).to not_eq(rule.created_at)
  #     end
  #   end
  # end
end