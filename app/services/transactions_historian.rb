module TransactionsHistorian
  def build_responce
    account_user
    transactions_history(role)
  end

  private

  def account_user
    @account_user ||= AccountUser.find_by(user_id: current_user, account_id: account_id)
  end

  def account_id
    Account.find_by(hash_id: params[:account_id])
  end

  def role
    @role ||= account_user.role.name
  end

  def transactions
    @account_user.account.transactions
  end

  def transactions_history(role_type)
    @transactions = role_type == 'owner' ? transactions : transactions.where(user_id: current_user.id)
  end
end
