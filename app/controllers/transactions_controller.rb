class TransactionsController < ApplicationController
  def create
    transaction_creator = TransactionCreator.new(params, current_user)
    transaction_creator.create_transaction
    format.html { redirect_to transaction_creator.account, notice: 'Transaction was successfully created.' }
  end
end
