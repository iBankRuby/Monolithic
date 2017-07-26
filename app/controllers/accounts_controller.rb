class AccountsController < ApplicationController
  before_action :set_account, only: %i[show destroy]

  def index
    @user = User.find(current_user.id)              # list of accounts of user
    @accounts = @user.accounts
  end

  def new
    @account = Account.new
  end

  def create
    @user = User.find(current_user.id)
    @account = Account.create(iban: Forgery('credit_card').number, balance: 1000)
    @account.roles.create(user: @user, role: 'owner')
    respond_to do |format|
      if @account.save
        format.html { redirect_to @account, notice: 'Account was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  def show
    @account = Account.find(params[:id])
    @my_transactions = Transaction.where(user_id: current_user.id, account_id: params[:id])
    @income = Transaction.where(remote_account_id: @account.iban.to_s, status_to: false )
    @income.to_a
  end

  def destroy
    @account.destroy
    # respond_to do |format|
    #  format.html { redirect_to account_url, notice: 'User was successfully destroyed.' }
    #  format.json { head :no_content }
    # end
    redirect_to :users
  end

  private

  def set_account
    @account = Account.find(params[:id])
  end

  # def account_params
  #  params.fetch(:account).permit(:user_id)
  # end
end
