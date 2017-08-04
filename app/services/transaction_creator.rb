class TransactionCreator
  # interface
  # def self.create_transaction(params, user)
  #   transaction_creator = new(params, user)
  #   transaction_creator.create_transaction
  #   transaction_creator.account
  # end

  attr_reader :params, :user, :account

  def initialize(params, user)
    @params = params
    @user = user
  end

  def create_transaction
    ActiveRecord::Base.transaction do
      create_transaction_object
      update_account_from
      update_account_to
    end

    @account = account_from
  end

  private

  # implementation

  def create_transaction_object
    Transaction.create(remote_account_id: params[:account],
                       summ: summ,
                       status_from: true,
                       status_to: false,
                       user: user,
                       account: account_from)
  end

  def update_account_from
    account_from.balance -= summ
    binding.pry
    account_from.save!
  end

  def update_account_to
    account_to.balance += summ
    account_to.save!
  end

  # def user
  #   @user ||= User.find(current_user.id)
  # end

  def account_from
    @account_from ||= Account.find(params[:account_id])
  end

  def account_to
    @account_to ||= Account.find_by(iban: params[:account])
  end

  def summ
    params[:summ].to_f
  end
end
