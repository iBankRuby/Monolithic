# frozen_string_literal: true

class AccountsController < ApplicationController
  before_action :set_account, only: %i[show destroy]

  attr_reader :accounts, :account, :income

  def index
    @accounts = current_user.accounts
    @invites = Invite.where(user_to_id: current_user.id, status: nil)
  end

  def new
    @account = Account.new
  end

  def create
    iban = Ibandit::IBAN.new(country_code: 'BE',
                             account_number: Forgery('credit_card').number)
    account = Account.create!(iban: iban.iban,
                              balance: 1000)
    account.account_users.create(user: current_user, role_id: Role.find_by(name: 'owner').id)
    redirect_to account, notice: 'Account was successfully created.'
  end

  def show
    @transactions = Transaction.where(user_id: current_user.id, account_id: account.id, status_from: true)
    @income = Transaction.where(remote_account_id: account.iban.to_s, status_to: false)
  end

  def destroy
    account.destroy
    redirect_to accounts_url
  end

  private

  def set_account
    @account = Account.find(params[:id])
  end
end
