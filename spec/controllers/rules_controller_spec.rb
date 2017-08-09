# require 'rails_helper'
#
# RSpec.describe RulesController, type: :controller do
#   let(:user) { create(:user) }
#   let(:account) { create(:account) }
#   let(:rule) { create(:rule) }
#
#   before { sign_in user }
#
#   describe 'GET index' do
#     it 'has a 200 status code' do
#       get :index, params: { account_id: account.id }
#       expect(response).to have_http_status :ok
#     end
#
#     it 'render index template' do
#       get :index, params: { account_id: account.id }
#       expect(response).to render_template :index
#     end
#   end
#
#   describe 'GET new' do
#     it 'has a 200 status code' do
#       get :new, params: { account_id: account.id }
#       expect(response).to have_http_status :ok
#     end
#
#     it 'render new template' do
#       get :new, params: { account_id: account.id }
#       expect(response).to render_template :new
#     end
#   end
#
#   describe 'GET edit' do
#     it 'has a 200 status code' do
#       get :edit, params: { account_id: account.id, id: rule.id }
#       expect(response).to have_http_status :ok
#     end
#
#     it 'render edit template' do
#       get :edit, params: { account_id: account.id, id: rule.id }
#       expect(response).to have_http_status :ok
#     end
#   end
#
#   describe 'POST create' do
#     context 'with valid params' do
#       it 'creates new rule group' do
#         rules_count = Rule.count
#         post :create, params: { account_id: account.id, account_rule: { spending_limit: 123 } }
#         expect(Rule.count).to eq(rules_count.next)
#       end
#
#       it 'redirect to account rules' do
#         post :create, params: { account_id: account.id, account_rule: { spending_limit: 123 } }
#         expect(response).to redirect_to :account_rules
#       end
#     end
#
#     context 'with invalid params' do
#       it 'does not create rule with negative spending limit' do
#         post :create, params: { account_id: account.id, account_rule: { spending_limit: -1 } }
#         expect(Rule.find_by(spending_limit: -1)).to be_nil
#       end
#
#       it 'redirect to new account rule' do
#         post :create, params: { account_id: account.id, account_rule: { spending_limit: -1 } }
#         expect(response).to redirect_to :new_account_rule
#       end
#     end
#   end
#
#   describe 'PATCH update' do
#     context 'with valid params' do
#       it 'updates spending limit' do
#         patch :update, params: { account_id: account.id, id: rule.id, account_rule: { spending_limit: 1 } }
#         expect(Rule.find(rule.id).spending_limit).to eq(1)
#       end
#     end
#
#     context 'with invalid params' do
#       it 'does not updates spending limit to negative' do
#         patch :update, params: { account_id: account.id, id: rule.id, account_rule: { spending_limit: -1 } }
#         expect(Rule.find(rule.id).spending_limit).not_to eq(-1)
#       end
#     end
#   end
# end
