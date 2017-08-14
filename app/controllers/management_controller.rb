# frozen_string_literal: true

class ManagementController < ApplicationController
  before_action :account

  def index
    account
    account_manager = AccountManager.new(current_user, acc_id)
    @account_users = account_manager.manage
  end

  def destroy
    AccountUser.find_by(id: params[:id]).really_destroy!
    redirect_to account_management_index_path, notice: 'Co-user was successfully deleted.'
  end

  private

  def account
    @account = Account.friendly.find(params[:account_id])
  end

  def acc_id
    @account.id
  end
end
