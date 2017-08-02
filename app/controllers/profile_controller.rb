class ProfileController < ApplicationController
	attr_reader :accounts, :user

	def index
	  @user = current_user
	  @accounts = user.accounts
	end
  
end