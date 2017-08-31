require 'rails_helper'

RSpec.describe InvitesController, type: :controller do
  let!(:user) { create :user }
  let!(:another_user) { create :another_user }
  let!(:account) { create :account }
  let!(:invite) { create :invite,
                    account_id: account.id,
                    user_from_id: user.id,
                    user_to_email: another_user.email }
  let!(:rule) { create(:rule, invite_id: invite.id) }
  let!(:invites_tracker) { create(:invites_tracker, 
                            invite_id: invite.id, 
                            limit: invite.rule.spending_limit) }
  before { sign_in user }

  describe 'GET index' do
    it 'has a 200 status code' do
      get :index, params: {account_id: account.id }
      expect(response).to have_http_status :ok
    end

    it 'render index template' do
      get :index, params: {account_id: account.id }
      expect(response).to render_template :index
    end
  end

  describe 'POST create' do
    context 'with valid params' do
      it 'creates a new invite' do
        post :create, params: { account_id: account.id,
                                invite: { email: 'user@mail.com',
                                rule: { spending_limit: 1 } } }
        invite = Invite.find_by(user_to_email: another_user.email)
        expect(Invite.exists?(invite.id)).to be_truthy
      end

      it 'redirect to invites' do
        post :create, params: { account_id: account.id,
                                invite: { email: 'user@mail.com',
                                rule: { spending_limit: 1 } } }
        expect(response).to redirect_to account_invites_url
      end
    end

    context 'with invalid params' do
      it 'does not create invite without email' do
        post :create, params: { account_id: account.id,
                                invite: { email: '' ,
                                rule: { spending_limit: 1 } } }
        expect(Invite.count).to eq(0)
      end

      it 'does not create invite to same user' do
        post :create, params: { account_id: account.id,
                                invite: { email: 'user@mail.com' ,
                                rule: { spending_limit: 1 } } }
        expect(Invite.find_by(user_from_id: user.id, user_to_email: another_user.email)).to be_nil
      end

      it 'does not create invite twice' do
        post :create, params: { account_id: account.id,
                                invite: { email: 'user@mail.com',
                                rule: { spending_limit: 1 } } }
        post :create, params: { account_id: account.id,
                                invite: { email: 'user@mail.com',
                                rule: { spending_limit: 1 } } }
        expect(Invite.where(user_to_email: another_user.email).count).to eq(1)
      end

      it 'will redirect to invites if user is nonexist' do
        post :create, params: { account_id: account.id,
                                invite: { email: 'user123@mail.com',
                                rule: { spending_limit: 1 } } }
        expect(response).to redirect_to account_invites_url
      end
    end
  end

  describe 'DELETE destroy' do
    it 'removes an invitation' do
      delete :destroy, params: { account_id: account.id, id: invite.id }
      expect(Invite.find(invite.id).status).to eq('canceled')
    end
  end
end

RSpec.describe InvitesController, type: :controller do
  let!(:user) { create :user }
  let!(:another_user) { create :another_user }
  let!(:account) { create :account }
  let!(:invite) { create :invite,
                    account_id: account.id,
                    user_from_id: user.id,
                    user_to_email: another_user.email,
                    status: 'confirmed'}
  let!(:rule) { create(:rule, invite_id: invite.id) }
  let!(:invites_tracker) { create(:invites_tracker, 
                            invite_id: invite.id, 
                            limit: invite.rule.spending_limit) }
  before { sign_in user }
  context 'DELETE destroy' do    
    it 'redirect to account_invites with error' do      
      delete :destroy, params: { account_id: account.id, id: invite.id }
      expect(response).to redirect_to :account_invites
    end
  end
end


# describe 'PATCH update' do
#   let! :user do
#     create :user
#   end
#
#   before :each do
#     FactoryGirl.create :user, id: 1, email: 'me55@mail.ru'
#     @user2 = FactoryGirl.create :user, id: 2, email: 'me3@mail.ru'
#     @account = FactoryGirl.create :account
#     @invite = FactoryGirl.create :invite, account_id: @account.id
#   end
#
#   before do
#     Timecop.freeze(Date.today + 10)
#   end
#
#   after do
#     Timecop.return
#   end
#
#   context 'with valid params' do
#     it 'redirect to account' do
#       patch :update, params: { id: @invite.id, account_id: @account.id, invite: { status: true } }
#       expect(response).to redirect_to :accounts
#     end
#
#     it 'set invite status to true' do
#       patch :update, params: { id: @invite.id, account_id: @account.id, invite: { status: true } }
#       expect(Invite.find(@invite.id).status).to be_truthy
#     end
#
#     it 'set invite status to false' do
#       patch :update, params: { id: @invite.id, account_id: @account.id, invite: { status: false } }
#       expect(Invite.find(@invite.id).status).to be_falsey
#     end
#
#     it 'will be updated later than created' do
#       patch :update, params: { id: @invite.id, account_id: @account.id, invite: { status: true } }
#       invite = Invite.find(@invite.id)
#       expect(invite.updated_at).not_to eq(invite.created_at)
#     end
#   end
#
#   context 'with invalid params' do
#     it 'won\'t update invite status' do
#       patch :update, params: { id: @invite.id, account_id: @account.id, invite: { status: nil } }
#       invite = Invite.find(@invite.id)
#       expect(invite.updated_at).to eq(invite.created_at)
#     end
#   end
# end

  

RSpec.describe InvitesController, type: :controller do
  let!(:user) { create :user }
  let!(:another_user) { create :another_user }
  let!(:account) { create :account }
  let!(:invite) { create :invite,
                    account_id: account.id,
                    user_from_id: user.id,
                    user_to_email: another_user.email}
  let!(:rule) { create(:rule, invite_id: invite.id) }
  let!(:invites_tracker) { create(:invites_tracker, 
                            invite_id: invite.id, 
                            limit: invite.rule.spending_limit) }
  before { sign_in another_user }
  context 'PATCH confirm' do
    it 'redirect to account' do
      patch :confirm, params: { account_id: account.id, invite_id: invite.id }
      expect(response).to redirect_to :accounts
    end
  end

  describe 'PATCH reject' do
    it 'changes invite status to rejected' do
      patch :reject, params: { account_id: account.id, invite_id: invite.id }
      expect(response).to redirect_to :accounts
    end
  end
end

RSpec.describe InvitesController, type: :controller do
  let!(:user) { create :user }
  let!(:another_user) { create :another_user }
  let!(:account) { create :account }
  let!(:invite) { create :invite,
                    account_id: account.id,
                    user_from_id: user.id,
                    user_to_email: another_user.email,
                    status: 'canceled'}
  let!(:rule) { create(:rule, invite_id: invite.id) }
  let!(:invites_tracker) { create(:invites_tracker, 
                            invite_id: invite.id, 
                            limit: invite.rule.spending_limit) }
  before { sign_in another_user }
  context 'PATCH confirm' do    
    it 'redirect to account with error' do      
      patch :confirm, params: { account_id: account.id, invite_id: invite.id }
      expect(response).to redirect_to :accounts
    end
  end
  context 'PATCH reject' do    
    it 'redirect to account with error' do      
      patch :reject, params: { account_id: account.id, invite_id: invite.id }
      expect(response).to redirect_to :accounts
    end
  end
end