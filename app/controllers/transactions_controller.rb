class TransactionsController < ApplicationController
  before_action :set_transaction, only: %i[show edit update destroy]

  def index
    @user = User.find(current_user.id)
    @transactions = @user.transactions
  end

  def show; end

  def new; end

  def edit; end

  def create
    create_cookie_transaction
    send_cookie
    recieve_cookie
    respond_to do |format|
      if @transaction.save
        format.html { redirect_to @account, notice: 'Transaction was successfully created.' }
      end
    end
  end

  def update
    respond_to do |format|
      if @transaction.update(transaction_params)
        format.html { redirect_to @transaction, notice: 'Transaction was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    @transaction.destroy
    respond_to do |format|
      format.html { redirect_to transactions_url, notice: 'Transaction was successfully destroyed.' }
    end
  end

  private

  def create_cookie_transaction
    @user = User.find(current_user.id)
    @account = Account.find(params[:account_id])
    @transaction = Transaction.create(remote_account_id: params[:account],
                                      summ: params[:summ],
                                      status_from: true,
                                      status_to: false)
    @user.transactions << @transaction
    @account.transactions << @transaction
  end

  def send_cookie
    @account.balance -= @transaction.summ
    @account.save
  end

  def recieve_cookie
    @account_to = Account.find_by(iban: params[:account])
    @account_to.balance += @transaction.summ
    @account_to.save
  end

  def set_transaction
    @transaction = Transaction.find(params[:id])
  end

  def transaction_params
    params.fetch(:transaction, {})
  end
end
