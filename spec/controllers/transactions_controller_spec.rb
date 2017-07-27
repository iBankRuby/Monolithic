require 'rails_helper'

RSpec.describe TransactionsController, type: :controller do
  let!(:user) do
    create(:user)
  end

  let(:account_to) { create(:account, balance: 1000) }
  let(:account_from) { create(:account, balance: 1000) }

  let!(:transaction_params) do
    #rewrite to account_from, account_to and ibans
    {
        :account_id => account_from.id,
        :account    => account_to.iban,
        :summ => 100.0
    }
  end

  let(:valid_attributes) do
    skip('Add a hash of attributes valid for your model')
  end

  let(:invalid_attributes) do
    skip('Add a hash of attributes invalid for your model')
  end

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # TransactionsController. Be sure to keep this updated too.
  let(:valid_session) { {} }

  describe 'POST #create' do
    context 'with valid params' do
      it 'creates a new Transaction' do
        expect do
          post :create, params: { transaction: valid_attributes }, session: valid_session
        end.to change(Transaction, :count).by(1)
      end

      it 'redirects to the created transaction' do
        post :create, params: { transaction: valid_attributes }, session: valid_session
        expect(response).to redirect_to(Transaction.last)
      end
    end

    context 'with invalid params' do
      it "returns a success response (i.e. to display the 'new' template)" do
        post :create, params: { transaction: invalid_attributes }, session: valid_session
        expect(response).to be_success
      end
    end
  end

end
