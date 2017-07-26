class TransactionsController < ApplicationController
  before_action :set_transaction, only: %i[show edit update destroy]

  # GET /transactions
  # GET /transactions.json
  def index
    @user = User.find(current_user.id)
    @transactions = @user.transactions
  end

  # GET /transactions/1
  # GET /transactions/1.json
  def show; 
    @account = Account.find(params[:id])
    @my_transactions = Transaction.where(user_id: current_user.id, account_id: params[:id])
  end

  # GET /transactions/new
  def new
    @transaction = Transaction.new
  end

  # GET /transactions/1/edit
  def edit; end

  # POST /transactions
  # POST /transactions.json
  def create
    @user = User.find(current_user.id)
    @account = Account.find(params[:account_id])
    @transaction = Transaction.create(remote_account_id: params[:account], summ: params[:summ], status_from: true, status_to: false )
    @user.transactions << @transaction
    @account.transactions << @transaction
    @account.balance -= @transaction.summ
    @account.save
    @account = Account.find_by(iban: params[:account])
    @account.balance += @transaction.summ
    @account.save
    respond_to do |format|
      if @transaction.save
        format.html { redirect_to @account, notice: 'Transaction was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  # PATCH/PUT /transactions/1
  # PATCH/PUT /transactions/1.json
  def update
    respond_to do |format|
      if @transaction.update(transaction_params)
        format.html { redirect_to @transaction, notice: 'Transaction was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  # DELETE /transactions/1
  # DELETE /transactions/1.json
  def destroy
    @transaction.destroy
    respond_to do |format|
      format.html { redirect_to transactions_url, notice: 'Transaction was successfully destroyed.' }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_transaction
    @transaction = Transaction.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list
  # through.
  def transaction_params
    params.fetch(:transaction, {})
  end
end
