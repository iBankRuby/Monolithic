require 'rails_helper'

describe AccountManager do
  describe '#build_response' do
    let!(:user) do
      create(:user)
    end

    let!(:co_user) { create(:user, email: 'test01@mail.by') }
    let!(:account) { create(:account, balance: 1000) }
    let!(:usr_acc) { create(:account_user,
                          user_id: user.id,
                          account_id: account.id,
                          role_id: 1) }
    let!(:usr_acc_couser) { create(:account_user,
                            user_id: co_user.id,
                            account_id: account.id,
                            role_id: 2) }
    let!(:limit) { create(:limit, account_user_id: usr_acc_couser.id) }

    let(:manager) { described_class.new(user, account.id) }

    it 'build_response' do
      expect(manager.account_id).to eq(account.id)
      expect(manager.manage[:account_users].last.user_id).to eq(co_user.id)
    end
  end
end
