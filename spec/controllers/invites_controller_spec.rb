require 'rails_helper'
require 'pry'

RSpec.describe InvitesController, type: :controller do
  let!(:user) { create :user }
  let!(:another_user) { create :another_user }
  let!(:account) { create :account }

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
        post :create, params: { account_id: account.id, invite: { email: 'user@mail.com' } }

        invite = Invite.find_by(user_to_id: another_user.id)
        expect(Invite.exists?(invite.id)).to be_truthy
      end

      it 'redirect to invites' do
        post :create, params: { account_id: account.id, invite: { email: 'user@mail.com' } }
        expect(response).to redirect_to account_invites_url
      end
    end

    context 'with invalid params' do
      it 'does not create invite without email' do
        post :create, params: { account_id: account.id, invite: { email: '' } }
        expect(Invite.count).to eq(0)
      end

      it 'does not create invite to same user' do
        post :create, params: { account_id: account.id, invite: { email: 'me@example.com' } }
        expect(Invite.find_by(user_from_id: user.id, user_to_id: another_user.id)).to be_nil
      end

      it 'does not create invite twice' do
        post :create, params: { account_id: account.id, invite: { email: 'user@mail.com' } }
        post :create, params: { account_id: account.id, invite: { email: 'user@mail.com' } }
        expect(Invite.where(user_to_id: another_user.id).count).to eq(1)
      end
    end
  end

  describe 'PATCH update' do
    let! :user do
      create :user
    end
    before :each do
      sign_in user
       FactoryGirl.create :user, :id => 1, :email => 'me55@mail.ru'
      @user2 = FactoryGirl.create :user, :id => 2, :email => 'me3@mail.ru'
      @account = FactoryGirl.create :account
      @invite = FactoryGirl.create :invite, :account_id => @account.id
    end

    it 'redirect to account' do
      patch :update, params: { id: @invite.id, account_id: @account.id, user: @user2.id }
      expect(response).to redirect_to :accounts
    end
  end

  describe 'DELETE destroy' do
    it 'removes an invitation' do
      invite = Invite.create(user_from_id: user.id, user_to_id: another_user.id, account_id: account.id)
      delete :destroy, params: { account_id: account.id, id: invite.id }
      expect(Invite.exists?(invite.id)).to be_falsey
    end
  end
end
