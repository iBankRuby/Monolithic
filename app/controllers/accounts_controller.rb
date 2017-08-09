class AccountsController < ApplicationController
  before_action :set_account, only: %i[show destroy]

  attr_reader :accounts, :account, :income

  def index
    accounts_list
    invites_list
  end

  def new
    @account = Account.new
  end

  def create
    iban = Ibandit::IBAN.new(country_code: 'BE',
                             account_number: Forgery('credit_card').number)
    account = Account.create!(iban: iban.iban,
                              balance: 1000)
    account.account_users.create(user: user, role_id: Role.find_by(name: 'owner').id)
    redirect_to account, notice: 'Account was successfully created.'
  end

  def show
    outgoing_transactions_list
    incoming_transactions_list
  end

  def update
    Account.friendly.restore(params[:id], recursive: true)
    redirect_to accounts_url
  end

  def destroy
    account.destroy
    redirect_to accounts_url
  end

  private

  def set_account
    @account = Account.friendly.find(params[:id])
  end

  def user
    @user ||= current_user
  end

  def accounts_list
    @accounts = user.accounts
  end

  def invites_list
    @invites = Invite.where(user_to_id: user.id, status: nil)
  end

  def outgoing_transactions_list
    @transactions = Transaction.where(user_id: user.id, account_id: account.id, status_from: true)
  end

  def incoming_transactions_list
    @income = Transaction.where(remote_account_id: account.iban.to_s, status_from: true)
  end
end
