class AccountsController < ApplicationController
  before_action :set_account, only: %i[show destroy]
  before_action :set_current_user, only: %i[index create]

  attr_reader :accounts, :user

  def index
    @accounts = user.accounts
  end

  def new
    @account = Account.new
  end

  def create
    @account = Account.new(iban: Faker::Number.number(16), balance: 1000)

    respond_to do |format|
      if @account.save
        @account.roles.create(user: user, role: 'owner')

        format.html { redirect_to @account, notice: 'Account was successfully created.' }
        format.json { render :show, status: :created, location: user }
      else
        format.html { render :new }
        format.json { render json: user.errors, status: :unprocessable_entity }
      end
    end
  end

  def show; end

  def destroy
    @account.destroy
    redirect_to :users
  end

  private

  def set_account
    @account = Account.find(params[:id])
  end

  def set_current_user
    @user = User.find(current_user.id)
  end
end
