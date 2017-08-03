class ManagementController < ApplicationController
  before_action :set_account

  def index
    @roles = Role.where(account_id: @account.id)
  end

  def destroy
    Role.find_by(id: params[:id]).destroy
  end

  private

  def set_account
    @account = Account.find(params[:account_id])
  end
end
