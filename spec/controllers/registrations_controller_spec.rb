require 'rails_helper'

RSpec.describe RegistrationsController, type: :controller do
  include Devise::Test::ControllerHelpers
  before do
    @request.env["devise.mapping"] = Devise.mappings[:user]
  end
	describe 'POST create' do
    it 'has 302 status code' do
      post :create, params: { user: {name: "etetr", email: "4@www.ddd", password: "[FILTERED]", password_confirmation: "[FILTERED]"}, commit: "Sign up" }
      expect(response).to have_http_status :found
    end

    it 'render root' do
      post :create, params: { user: {name: "etetr", email: "4@www.ddd", password: "[FILTERED]", password_confirmation: "[FILTERED]"}, commit: "Sign up" }
      expect(response).to redirect_to :root
    end
  end
end