# frozen_string_literal: true

# Module requires role, summ, account_from, account_to
module TransactionService
  def transact
    carry_out
  end

  private

  def carry_out
    update_account_from
    update_account_to
    role.eql?('co-user') && update_remainder
  end

  def update_account_from
    account_from.balance -= summ
    account_from.save!
  end

  def update_account_to
    account_to.balance += summ
    account_to.save!
  end

  def update_remainder
    @remainder -= summ < remainder ? summ : 0
    account_user.limit.save
  end
end
