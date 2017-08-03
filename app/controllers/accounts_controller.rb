class AccountsController < ApplicationController
  before_action :set_account, only: %i[show destroy]
  before_action :set_current_user, only: %i[index create show]

  attr_reader :accounts, :user, :account, :income

  def index
    @accounts = user.accounts
    @invites = Invite.where(user_to_id: user.id, status: nil)
  end

  def new
    @account = Account.new
  end

  def create
    account = Account.create!(iban: Forgery('credit_card').number, balance: 1000)
    account.account_users.create(user: user, role_id: Role.find_by_name('owner').id)
    redirect_to account, notice: 'Account was successfully created.'
  end

  def show
    @transactions = Transaction.where(user_id: user.id, account_id: account.id)
    @income = Transaction.where(remote_account_id: account.iban.to_s, status_to: false)
    @roles = Role.where(account_id: params[:id])
  end

  def destroy
    account.destroy
    redirect_to accounts_url
  end

  private

  def set_account
    @account = Account.find(params[:id])
  end

  def set_current_user
    @user = current_user
  end
end
