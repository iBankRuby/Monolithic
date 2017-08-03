class ManagementController < ApplicationController

  def index
    @account = Account.find(params[:account_id])
    @account_users = AccountUser.where(account_id: params[:account_id])
  end

  def destroy
    AccountUser.find_by(id: params[:id]).destroy
  end
end
