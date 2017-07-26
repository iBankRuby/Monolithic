class AccountsController < ApplicationController
  before_action :set_account, only: %i[show destroy]

  def index
    # puts Account
    @user = User.find(current_user.id)
    @accounts = @user.accounts
    p @accounts
    # @accounts = User.accounts.find(current_user.id)
  end

  def new
    @account = Account.new
  end

  def create
    @user = User.find(current_user.id)
    @account = Account.create(iban: Forgery('credit_card').number)
    @account.roles.create(user: @user, role: 'owner')
    #    if @account.save
    #    #  format.html { redirect_to @account, notice: 'Account was successfully created.' }
    #    end

    respond_to do |format|
      if @account.save
        format.html { redirect_to @account, notice: 'Account was successfully created.' }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def show
    @account = Account.find(params[:id])
    @my_transactions = Transaction.find_by(user_id: current_user.id, account_id: params[:id])
    @income = Transaction.find_by(remote_account_id: @account.iban.to_s, status_to: false )
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
    @account.balance ||= 1000
  end

  # def account_params
  #  params.fetch(:account).permit(:user_id)
  # end
end
