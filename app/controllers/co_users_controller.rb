# frozen_string_literal: true

class CoUsersController < ApplicationController
  def show
    @account = Account.find(params[:account_id])
    user_transactions = Transaction.where(user_id: params[:id], account_id: account.id)
    @transactions = user_transactions.where(status_from: true)
    @unconfirmed = user_transactions.where(status_from: false)
    # @rule = Rule.find(params[:account_id])
  end

  private

  def account
    @account = Account.find(params[:account_id])
  end
end
