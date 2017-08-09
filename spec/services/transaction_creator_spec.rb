require 'rails_helper'

describe TransactionCreator do
  describe '#create_transaction' do
    let!(:user) do
      create(:user)
    end

    let!(:account_to) { create(:account, balance: 1000) }
    let!(:account_from) { create(:account, balance: 1000) }
    let!(:usr_acc) { create(:account_user,
                          user_id: user.id,
                          account_id: account_from.id,
                          role_id: 1) }
    let!(:limit) { create(:limit, account_user_id: usr_acc.id) }

    let!(:transaction_params) do
      # rewrite to account_from, account_to and ibans
      {
        account_id: account_from.id,
        account: account_to.iban,
        summ: 100.0
      }
    end

    let(:subject) { described_class.new(transaction_params, user) }

    it 'create transaction' do
      subject.create_transaction
      expect(subject.account).to eq(account_from)
      expect(account_from.reload.balance).to eq(900)
      expect(account_to.reload.balance).to eq(1100)
    end
  end
end
