# frozen_string_literal: true

class TransactionCreator
  attr_reader :params, :user, :account, :account_user

  include TransactionHandler::Transaction

  def initialize(args)
    @params = args[:params]
    @user = args[:user]
    @account_user ||= AccountUser.find_by(user_id: user.id, account_id: account_from.id)
  end

  def create_transaction
    ActiveRecord::Base.transaction do
      validator = TransactionValidator.new(self)
      if validator.valid?
        create_transaction_object
        carry_out
      end
    end

    @account = account_from
  end

  def check_creds
    expired = params[:account_to].valid_thru
    params[:day] != expired.strftime('%d') && params[:month] != expired.strftime('%m')
  end

  private

  def create_transaction_object
    Transaction.create(remote_account_id: params[:account],
                       summ: summ,
                       status_from: true,
                       status_to: false,
                       user: user,
                       account: account_from)
  end

  def account_from
    @account_from ||= Account.find(params[:account_id])
  end

  def account_to
    @account_to ||= Account.find_by(iban: params[:account])
  end

  def summ
    params[:summ].to_f
  end

  def remainder
    @remainder ||= account_user.limit.remainder if role.eql? 'co-user'
  end

  def role
    account_user.role.name
  end
end
