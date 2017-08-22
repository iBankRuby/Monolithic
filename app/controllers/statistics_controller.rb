class StatisticsController < ApplicationController
  before_action :set_account, only: %i[index]
  attr_reader :account
  include StatisticsBuilder

  def index
    users_list
    get_statistics if params[:utf8]
  end

  def create
    redirect_to account_statistics_path(@transactions)
  end

  private

  def set_account
    @account ||= Account.find_by(hash_id: params[:account_id])
  end

  def users_list
    @account_users = account.account_users
  end
end
