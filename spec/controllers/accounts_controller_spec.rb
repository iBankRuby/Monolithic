require 'rails_helper'

FactoryGirl.define do
  factory :user do
    email 'me@example.com'
    password 'secret'
  end
end

RSpec.describe AccountsController, type: :controller do

  before do
    @user = FactoryGirl.create :user
  end

  describe 'GET index' do
    it 'has a 200 status code' do
      sign_in @user

      get :index
      expect(response).to have_http_status :ok
    end


  end

  describe 'GET new' do
    it 'has a 200 status code' do
      sign_in @user

      get :new
      expect(response).to have_http_status :ok
    end
  end
end
