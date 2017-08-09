# frozen_string_literal: true

class HandlerOfPendingTransaction
  # TODO: Module requires role, summ, account_from, account_to
  include TransactionService

  # def confirm
  #   prepare_to_confirmation
  #   carry_out
  # end
  #
  # def build_request
  #   # later
  # end

  # def carry_out
  #   if confirmation
  #     update_account_from
  #     update_account_to
  #     update_remainder if confirming || role == 'co-user'
  #   end
  # end

  # def account_to
  #   @account_to ||= if confirming
  #                     Account.find_by(iban: transaction.remote_account_id)
  #                   else
  #                     Account.find_by(iban: params[:account])
  #                   end
  # end

  # def summ
  #   if confirming
  #     transaction.summ
  #   else
  #     params[:summ].to_f
  #   end
  # end

  # def prepare_to_confirmation
  #   @transaction = Transaction.find(params[:id])
  #   @confirmation = true
  #   transaction.status_from = confirmation
  #   transaction.save
  #   @confirming = true
  # end

  # def account_user
  #   @account_user ||= if confirming
  #     AccountUser.find_by(user_id: transaction.user_id, account_id: account_from_id)
  #   else
  #     AccountUser.find_by(user_id: user.id, account_id: account_from_id)
  #   end
  # end
end
