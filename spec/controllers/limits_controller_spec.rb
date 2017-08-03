require 'rails_helper'

RSpec.describe LimitsController, type: :controller do
  let(:user) { create(:user) }
  let(:account) { create(:account) }

  before { sign_in user }

  describe 'GET index' do
    it 'has a 200 status code' do
      get :index
      expect(response).to have_http_status :ok
    end

    it 'render index template' do
      get :index
      expect(response).to render_template :index
    end
  end
end
