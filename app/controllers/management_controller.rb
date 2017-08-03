class ManagementController < ApplicationController
  def index
    @account = Account.find(params[:account_id])
    @account_users = AccountUser.where(account_id: params[:account_id])
    before_action :set_account

    @roles = Role.where(account_id: @account.id)
  end

  def destroy
    AccountUser.find_by(id: params[:id]).destroy
  end

  private

  def set_account
    @account = Account.find(params[:account_id])
  end
end
