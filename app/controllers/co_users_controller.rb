class CoUsersController < ApplicationController

  def show
    @account = Account.find(params[:id])
    @transactions = Transaction.where(user_id: params[:id], account_id: account.id)
    @unconfirmed = Transaction.where(remote_account_id: account.iban.to_s, status_to: false, status_from: false)
  end

  private

  def account
    @account = Account.find(params[:id])
  end
end
