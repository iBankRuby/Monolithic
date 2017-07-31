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
      @user = FactoryGirl.create :user, :id => 2,  :email => 'me3@mail.ru'
      @invite = FactoryGirl.create :invite
    end

    it 'redirect to account' do
      patch :update, params: { id: @invite.id }
      expect(response).to redirect_to :accounts
    end

  end
end
