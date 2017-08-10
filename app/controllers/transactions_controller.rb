class TransactionsController < ApplicationController
  include TransactionsHistorian

  def index
    build_responce
  end

  def create
    transaction_creator = TransactionCreator.new(params, current_user)
    if transaction_creator.check_creds
      transaction_creator.create_transaction
      redirect_to transaction_creator.account, notice: 'Transaction was successfully created.'
    else
      redirect_to account_path(params[:account_id]), notice: 'Transaction was NOT created.'
    end
  end

  def update
    transaction_creator = TransactionCreator.new(params, current_user)
    transaction_creator.confirm
  end
end
