require 'rails_helper'
require 'pry'

RSpec.describe InvitesController, type: :controller do
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
end
