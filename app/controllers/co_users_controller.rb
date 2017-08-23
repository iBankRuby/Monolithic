class CoUsersController < ApplicationController
  def show
    account
    @transactions = Transaction.where(user_id: user_id, account_id: acc_id)
    @unconfirmed = Transaction.where(user_id: user_id, account_id: acc_id, status_from: 'in_approval')
    @rule = rule
  end

  def update
    rule.update!(co_user_params)
    limit.update!(reminder: co_user_params[:spending_limit])
    redirect_to :account_co_user, notice: 'Rules has been updated.'
  end

  private

  def account
    @account ||= Account.friendly.find(params[:account_id])
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

  def rule
    @rule ||= account_user.rule
  end

  def co_user_params
    params.fetch(:account_rule).permit(:spending_limit)
  end

  def limit
    account_user.limit
  end
end
