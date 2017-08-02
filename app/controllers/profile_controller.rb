class ProfileController < ApplicationController
	attr_reader :accounts, :user

	def index
	  @user = current_user
	  @accounts = user.accounts
	end
  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end
end