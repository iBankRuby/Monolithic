# frozen_string_literal: true

class TransactionCreator
  include TransTracking

  attr_reader :params, :user, :account

  def initialize(params, user)
    @params = params
    @user = user
  end

  def check_creds
    return false if account_to.nil?
    expired = account_to.valid_thru
    return false if @params[:day] != expired.strftime('%d')
    return false if @params[:month] != expired.strftime('%m')
    true
  end

  def create_transaction
    ActiveRecord::Base.transaction do
      account_user
      @transaction = create_transaction_object
      create_trans_tracker(@transaction)
      # CancelOverdueTransaction.enqueue(transaction.id)
      #ExpireTransactionsWorker.perform_in(2.minutes, transaction.id)
    end
    @account = account_from
  end

  def confirm
    approve_transaction
    enough_of_money?
    carry_out
  end

  def cancel
    cancel_transaction
  end

  def approve_from_owner
    approve_exceeding_limit
    carry_out
  end

  def exchange
    create_transaction
    @account_from = Account.find(params[:account_id])
    transaction.process!
    enough_of_money?
    carry_out
  end

  private

  # implementation

  def enough_of_money?
    case role
    when 'co-user'
      if check_reminder
        transaction.approve!
        approve_cause
        set_total_time
      else
        transaction.need_approval!
        short_of_remainder
        track_in_approve
      end
    when 'owner'
      if check_balance
        transaction.approve!
        approve_cause
      else
        transaction.cancel!
        short_of_balance
      end
      set_total_time
    end
  end

  def check_reminder
    limit.reminder >= summ
  end

  def check_balance
    account_from.balance >= summ
  end

  def create_transaction_object
    Transaction.create(remote_account_iban: params[:account],
                       summ: summ,
                       status_to: false,
                       user: user,
                       account: account_from,
                       remainder: remainder,
                       balance: account_from.balance)
  end

  def carry_out
    return transaction.status_from unless transaction.approved?
    update_account_from
    update_account_to
    update_reminder if @confirming && role == 'co-user'
  end

  def update_account_from
    transaction.update(balance_after: account_from.balance -= summ)
    account_from.save!
  end

  def update_account_to
    transaction.update(remote_balance_after: account_to.balance += summ)
    account_to.save!
  end

  def update_reminder
    limit.reminder = limit.reminder > summ ? limit.reminder -= summ : 0
    limit.save
  end

  def account_user
    return @account_user ||= AccountUser.find_by(user_id: user.id, account_id: account_from) unless @confirming
    @account_user ||= AccountUser.find_by(user_id: transaction.user_id, account_id: account_from)
  end

  def account_from
    @account_from ||= Account.friendly.find(params[:account_id])
  end

  def account_to
    return @account_to ||= Account.find_by(iban: params[:account]) unless @confirming
    @account_to ||= Account.find_by(iban: transaction.remote_account_iban)
  end

  def summ
    return params[:summ].to_f unless @confirming
    transaction.summ
  end

  def role
    @role = account_user.role.name
  end

  def limit
    account_user.limit
  end

  def remainder
    limit.reminder if role == 'co-user'
  end

  def approve_transaction
    transaction.process!
    track_process
    @confirming = true
  end

  def cancel_transaction
    transaction.cancel!
    cancel_cause
    set_total_time
  end

  def approve_exceeding_limit
    transaction.approve_exceeding!
    track_approve_exceeding
    @confirming = true
  end

  def transaction
    @transaction ||= Transaction.find(params[:transaction_id])
  end

  def create_trans_tracker(trans)
    TransTracker.create!(transaction_id: trans.id, pending_time: trans.created_at)
  end
end
