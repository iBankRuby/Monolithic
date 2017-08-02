class ManagementController < ApplicationController
  def index
    p params
    @account = Account.find(params[:account_id])
    # @roles = Role.where(account_id: params[:account_id])
  end

  def show
    p params
    # @roles = Role.where(account_id: params[:account_id])
  end

  def destroy
    # Role.find_by(id: params[:id]).destroy
  end
end
