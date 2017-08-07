class TransactionsController < ApplicationController
  def create
    transaction_creator = TransactionCreator.new(params, current_user)
    transaction_creator.create_transaction
    redirect_to transaction_creator.account, notice: 'Transaction was successfully created.'
  end

  # def update
  #   transaction_creator = TransactionCreator.new(params, current_user)
  #   transaction_creator.confirm
  #   redirect_to transaction_creator.account, notice: 'Transaction was successfully created.'
  # end
end
