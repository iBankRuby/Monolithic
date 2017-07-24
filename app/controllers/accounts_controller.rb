class AccountsController < ApplicationController
  before_action :set_account, only: [:show]

  def create
    @account = Account.new(account_params)
    @account.account_number = Forgery('credit_card').number

    if @account.save
      format.html { redirect_to @account, notice: 'Account was successfully created.' }
    end
  end

  def show
  end

  private

  def set_account
    @account = Account.find(params[:id])
  end

  def account_params
    params.fetch(:account).permit(:user_id)
  end
end
