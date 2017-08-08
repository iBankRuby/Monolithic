# frozen_string_literal: true

class TransactionCreator
  # interface
  # def self.create_transaction(params, user)
  #   transaction_creator = new(params, user)
  #   transaction_creator.create_transaction
  #   transaction_creator.account
  # end

  attr_reader :params, :user, :account, :remainder, :confirmation, :transaction, :account_user, :confirming

  def initialize(args)
    @params = args[:params]
    @user = args[:user]
    @remainder = account_user.limit.remainder
  end

  def check_creds
    expired = account_to.valid_thru
    params[:day] != expired.strftime('%d') && params[:month] != expired.strftime('%m')
  end

  def create_transaction
    ActiveRecord::Base.transaction do
      check_confirmation
      create_transaction_object
      carry_out
    end

    @account = account_from
  end

  def confirm
    prepare_to_confirmation
    carry_out
  end

  private

  # implementation

  def check_confirmation
    account_user
    @confirmation = if role.eql? 'co-user'
                      check_remainder
                    else
                      check_balance
                    end
  end

  def check_remainder
    remainder >= summ
  end

  def check_balance
    account_from.balance >= summ
  end

  def create_transaction_object
    Transaction.create(remote_account_id: params[:account],
                       summ: summ,
                       status_from: confirmation,
                       status_to: false,
                       user: user,
                       account: account_from)
  end

  def carry_out
    if confirmation
      update_account_from
      update_account_to
      update_remainder if confirming || role == 'co-user'
    end
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

  def build_request
    # later
  end

  # def user
  #   @user ||= User.find(current_user.id)
  # end

  def account_user
    @account_user ||= if confirming
                        AccountUser.find_by(user_id: transaction.user_id, account_id: account_from_id)
                      else
                        AccountUser.find_by(user_id: user.id, account_id: account_from_id)
                      end
  end

  def account_from
    @account_from ||= Account.find(params[:account_id])
  end

  def account_to
    @account_to ||= if confirming
                      Account.find_by(iban: transaction.remote_account_id)
                    else
                      Account.find_by(iban: params[:account])
                    end
  end

  def summ
    if confirming
      transaction.summ
    else
      params[:summ].to_f
    end
  end

  def role
    @role = account_user.role.name
  end

  def account_from_id
    account_from.id
  end

  def prepare_to_confirmation
    @transaction = Transaction.find(params[:id])
    @confirmation = true
    transaction.status_from = confirmation
    transaction.save
    @confirming = true
  end
end
