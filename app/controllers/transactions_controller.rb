# frozen_string_literal: true

class TransactionsController < ApplicationController
  include TransactionsHistorian

  def index
    build_responce
  end

  def create
    transaction_creator = set_transaction
    if transaction_creator.check_creds
      transaction_creator.create_transaction
      redirect_to transaction_creator.account, notice: 'Transaction was successfully created.'
    else
      redirect_to account_path(params[:account_id]),
                  alert: 'Oops! Something wrong, try again later or contact administrator'
    end
  end

  def ownerapprove
    set_transaction.approve_from_owner
    redirect_to account_path(params[:account_id]), notice: 'Transaction was approved.'
  end

  def confirm
    redirection_router(set_transaction)
  end

  def cancel
    if set_transaction.cancel
      redirect_to account, notice: 'Transaction was cancelled.'
    else
      redirect_to account, notice: 'Transaction transaction already approved.'
    end
  end

  def exchange
    transaction_creator = set_exchange
    case transaction_creator.exchange
    when 'canceled'
      redirect_to exchange_account, notice: 'Not enough of money.'
    else
      redirect_to exchange_account, notice: 'Transaction completed successfully.'
    end
  end

  private

  def account
    account_path(params[:account_id])
  end

  def exchange_account
    account_path(Account.find_by(iban: params[:account]))
  end

  def set_transaction
    TransactionCreator.new(params, current_user)
  end

  def set_exchange
    params[:account] = Account.friendly.find(params[:account_id]).iban
    params[:account_id] = Account.find_by(iban: params[:refillable_account]).id
    TransactionCreator.new(params, current_user)
  end

  def redirection_router(transaction)
    account = account_path(params[:account_id])
    case transaction.confirm
    when 'canceled'
      redirect_to account, notice: 'Not enough money.'
    when 'in_approval'
      redirect_to account, notice: 'Exceeding the limit. Approve from owner requested.'
    else
      redirect_to account, notice: 'Transaction completed successfully.'
    end
  end
end
