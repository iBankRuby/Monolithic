class ManagementController < ApplicationController
  def index
    @account = Account.find(params[:account_id])
    @roles = Role.where(account_id: params[:account_id])
  end

  def destroy
    Role.find_by(id: params[:id]).destroy
  end
end
