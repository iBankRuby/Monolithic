require 'rails_helper'

RSpec.describe TransactionsController, type: :controller do
  describe 'POST #create owner' do
    let!(:user) do
      create(:user)
    end

    let!(:account_to) { create(:account, balance: 1000) }
    let!(:account_from) { create(:account, balance: 1000) }
    let!(:limit) { create(:limit) }
    let!(:usr_acc) { create(:account_user,
                           user_id: user.id,
                           account_id: account_from.id,
                           limit_id: limit.id,
                           role_id: 1) }

    let!(:transaction_params) do
      {
        account_id: account_from.id,
        account: account_to.iban,
        summ: 100.0,
        day: account_to.valid_thru.strftime('%d'),
        month: account_to.valid_thru.strftime('%m')
      }
    end

    before do
      sign_in user
    end

    context 'with valid params' do
      it 'creates a new Transaction' do
        expect do
          post :create, params: transaction_params
        end.to change(Transaction, :count).by(1)
      end
    end
  end

  describe 'POST #create co_user' do
    let!(:user) do
      create(:user)
    end

    let!(:account_to) { create(:account, balance: 1000) }
    let!(:account_from) { create(:account, balance: 1000) }
    let!(:limit) { create(:limit) }
    let!(:usr_acc) { create(:account_user,
                           user_id: user.id,
                           account_id: account_from.id,
                           limit_id: limit.id,
                           role_id: 2) }

    let!(:transaction_params) do
      {
        account_id: account_from.id,
        account: account_to.iban,
        summ: 50.0,
        day: account_to.valid_thru.strftime('%d'),
        month: account_to.valid_thru.strftime('%m')
      }
    end

    before do
      sign_in user
    end

    context 'with valid params' do
      it 'creates a new Transaction' do
        expect do
          post :create, params: transaction_params
        end.to change(Transaction, :count).by(1)
      end
    end
  end

  describe 'PUT #update co_user' do
    let!(:user) do
      create(:user)
    end

    let!(:account_to) { create(:account, balance: 1000) }
    let!(:account_from) { create(:account, balance: 1000) }
    let!(:limit) { create(:limit) }
    let!(:usr_acc) { create(:account_user,
                           user_id: user.id,
                           account_id: account_from.id,
                           limit_id: limit.id,
                           role_id: 2) }


    let!(:transaction) { create(:transaction,
                           user_id: user.id,
                           account_id: account_from.id,
                           remote_account_id: account_to.iban,
                           summ: 19.9,
                           status_from: false) }

    let!(:transaction_params) do
      {
        account_id: account_from.id,
        id: transaction.id,
      }
    end

    before do
      sign_in user
    end

    context 'with valid params' do
      it 'update unconfirmed Transaction' do
        put :update, params: transaction_params
        expect(transaction.reload.status_from).to eq(true)
      end
    end
  end
end
