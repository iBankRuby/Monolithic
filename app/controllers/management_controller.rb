# frozen_string_literal: true

class ManagementController < ApplicationController
  before_action :set_account, only: :index
  before_action :set_account_id, only: :index

  attr_reader :account_id

  def index
    @account_users = AccountManager.new(user: current_user, account_id: account_id).manage
  end

  def destroy
    AccountUser.find_by(id: params[:id]).destroy
    redirect_to account_management_index_path, notice: 'Co-user was successfully deleted.'
  end

  private

  def set_account_id
    @account_id = params[:account_id]
  end

  def set_account
    @account = Account.find(params[:account_id])
  end

  def acc_id
    params[:account_id]
  end
end
