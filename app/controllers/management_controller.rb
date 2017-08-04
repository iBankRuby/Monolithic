# frozen_string_literal: true

class ManagementController < ApplicationController
  def index
    @account = Account.find(params[:account_id])

    @roles = Role.where(account_id: @account.id)
    account_manager = AccountManager.new(current_user, params[:account_id])
    @account_users = account_manager.manage
  end

  def destroy
    AccountUser.find_by(id: params[:id]).destroy
  end

  private

  def set_account
    @account = Account.find(params[:account_id])
  end
end
