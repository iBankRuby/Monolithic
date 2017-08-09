RSpec.describe ExceedingRequestsController, type: :controller do
  let!(:user) { create(:user) }
  let!(:account) { create(:account) }
  let!(:account_user) do
    create(:account_user,
           user_id: user.id,
           account_id: account.id,
           role_id: Role.find_by(name: 'owner').id
    )
  end

  before { sign_in user }

  describe 'POST create' do
    context 'with valid params' do
      it 'would create request if it was created in new limit period' do
        post :create, params: { account_id: account.id, exceeding_request: { amount: 1 } }
        Timecop.freeze(Date.today + 1) do
          post :create, params: { account_id: account.id, exceeding_request: { amount: 2 } }
        end
        expect(ExceedingRequest.count).to eq(2)
      end
    end

    context 'with invalid params' do
      it 'would not create request if it was created in current limit period' do
        post :create, params: { account_id: account.id, exceeding_request: { amount: 1 } }
        post :create, params: { account_id: account.id, exceeding_request: { amount: 2 } }
        expect(ExceedingRequest.count).to eq(1)
      end
    end
  end

  describe 'DELETE destroy' do
    it 'will delete request from table' do
      req = ExceedingRequest.new(amount: 10)
      req.account_user = account_user
      req.save!
      count = ExceedingRequest.count
      delete :destroy, params: { account_id: account.id, id: req.id }
      expect(ExceedingRequest.count).to eq(count - 1)
    end
  end
end
