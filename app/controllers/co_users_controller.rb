class CoUsersController < ApplicationController
  def show
    account
    @transactions = Transaction.where(user_id: user_id, account_id: acc_id, status_from: true)
    @unconfirmed = Transaction.where(user_id: user_id, account_id: acc_id, status_from: false)
    @rule = account_user.rule
  end

  private

  def account
    @account ||= Account.find(params[:account_id])
  end

  def user_id
    params[:id]
  end

  def acc_id
    account.id
  end

  def account_user
    AccountUser.find_by(user_id: user_id, account_id: acc_id)
  end
end
