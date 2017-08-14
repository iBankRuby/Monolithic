class CoUsersController < ApplicationController

  def show
    @account = Account.find(params[:account_id])
    @transactions = Transaction.where(user_id: params[:id], account_id: account.id, status_from: true)
    @unconfirmed = Transaction.where(user_id: params[:id], account_id: account.id, status_from: false)
    #@rule = Rule.find(params[:account_id])
  end

  private

  def account
    @account = Account.find(params[:account_id])
  end
end
