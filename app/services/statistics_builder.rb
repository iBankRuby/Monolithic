module StatisticsBuilder
  # def get_statistics
  #   build_statistics
  # end

  def get_statistics
    account_user
    build_statistics(role)
  end

  private

  def clean_params
    params.delete_if { |key, value| value.blank? }
  end

  def account_user
    @account_user ||= AccountUser.find_by(user_id: current_user, account_id: account_id)
  end

  def account_id
    Account.find_by(hash_id: params[:account_id])
  end

  def role
    @role ||= account_user.role.name
  end

  # def first_ten
  #   account_user.account.transactions.order(created_at: :asc).reverse_order.limit(10).reverse
  # end

  def transactions
    account_user.account.transactions.where(clean_params)
  end

  def build_statistics(role_type)
    @transactions = role_type == "owner" ?  transactions : transactions.where(user_id: current_user.id)
  end
end