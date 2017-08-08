# frozen_string_literal: true

class TransactionValidator
  attr_reader :transaction, :role

  def initialize(transaction)
    @transaction = transaction
    @role = transaction.role
  end

  def valid?
    enough_money?
  end

  private

  def enough_money?
    role.eql?('co-user') ? check_remainder : check_balance
  end

  def check_remainder
    remainder >= summ
  end

  def check_balance
    transaction.account_from.balance >= summ
  end

  def summ
    transaction.summ
  end

  def remainder
    transaction.remainder
  end

  def account_user
    transaction.account_user
  end
end
