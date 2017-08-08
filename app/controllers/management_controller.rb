class ManagementController < ApplicationController
  before_action :set_account

  def index
    @account = Account.find(params[:account_id])
    account_manager = AccountManager.new(user: current_user, account_id: params[:account_id])
    @account_users = account_manager.manage
  end

  def destroy
    AccountUser.find_by(id: params[:id]).destroy
    redirect_to account_management_index_path, notice: 'Co-user was successfully deleted.'
  end

  private

  def set_account
    @account = Account.find(params[:account_id])
  end
end
