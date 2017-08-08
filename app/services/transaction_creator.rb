class TransactionCreator
  # interface
  # def self.create_transaction(params, user)
  #   transaction_creator = new(params, user)
  #   transaction_creator.create_transaction
  #   transaction_creator.account
  # end

  attr_reader :params, :user, :account, :limit

  def initialize(params, user)
    @params = params
    @user = user
  end

  def check_creds
    expired = account_to.valid_thru
    return false if @params[:day] != expired.strftime('%d')
    return false if @params[:month] != expired.strftime('%m')
    true
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
    return @confirmation = check_reminder if role == 'co-user'
    @confirmation = check_balance
  end

  def check_reminder
    limit.reminder >= summ
  end

  def check_balance
    account_from.balance >= summ
  end

  def create_transaction_object
    Transaction.create(remote_account_id: params[:account],
                       summ: summ,
                       status_from: @confirmation,
                       status_to: false,
                       user: user,
                       account: account_from)
  end

  def carry_out
    if @confirmation
      update_account_from
      update_account_to
      update_reminder if @confirming || role == 'co-user'
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

  def update_reminder
    if limit.reminder > summ
      limit.reminder -= summ
    else
      limit.reminder = 0
    end
    limit.save
  end

  def build_request
    #later
  end

  # def user
  #   @user ||= User.find(current_user.id)
  # end
  def account_user
    return @account_user ||= AccountUser.find_by(user_id: user.id, account_id: account_from.id) unless @confirming
    @account_user ||= AccountUser.find_by(user_id: @transaction.user_id, account_id: account_from.id)
  end

  def account_from
    @account_from ||= Account.find(params[:account_id])
  end

  def account_to
    return @account_to ||= Account.find_by(iban: params[:account]) unless @confirming
    @account_to ||= Account.find_by(iban: @transaction.remote_account_id)
  end

  def summ
    return params[:summ].to_f unless @confirming
    @transaction.summ
  end

  def role
    @role = account_user.role.name
  end

  def limit
    account_user.limit
  end

  def prepare_to_confirmation
    @transaction = Transaction.find(params[:id])
    @confirmation = true
    @transaction.status_from = @confirmation
    @transaction.save
    @confirming = true
  end
end
