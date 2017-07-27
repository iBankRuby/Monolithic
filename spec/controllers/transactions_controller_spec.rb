require 'rails_helper'

RSpec.describe TransactionsController, type: :controller do
  let!(:user) do
    create(:user)
  end

  let(:account_to) { create(:account, balance: 1000) }
  let(:account_from) { create(:account, balance: 1000) }

  let!(:transaction_params) do
    {
      account_id: account_from.id,
      account: account_to.iban,
      summ: 100.0
    }
  end

  before do
    sign_in user
  end

  describe 'POST #create' do
    context 'with valid params' do
      it 'creates a new Transaction' do
        expect do
          post :create, params: transaction_params
        end.to change(Transaction, :count).by(1)
      end
    end
  end
end
