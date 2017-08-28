module StatisticsBuilder
  # def get_statistics
  #   build_statistics
  # end

  def get_statistics
    account_user
    clean_params
    build_statistics
    invite_statistics
  end

  private

  def clean_params
    @range = created_at
    params.except(
      :utf8,
      :authenticity_token,
      :commit,
      :account_id,
      :controller,
      :action,
      :date_from,
      :date_to
    ).delete_if { |_key, value| value.blank? }.each do |k, v| # .merge(created_at)
      @range[k] = v
    end
    @range
  end

  def created_at
    if params[:date_from] != '' && !params[:date_from].nil?
      { created_at: params[:date_from].to_time..params[:date_to].to_time.end_of_day }
    else
      {}
    end
  end

  def account_user
    @account_user ||= AccountUser.find_by(user_id: current_user, account_id: account.id)
  end

  def role
    @role ||= account_user.role.name
  end

  # def first_ten
  #   account_user.account.transactions.order(created_at: :asc).reverse_order.limit(10).reverse
  # end

  def transactions
    income if role != 'co-user' && @range[:created_at]
    account_user.account.transactions.where(@range)
  end

  def income
    @income ||= Transaction.where(created_at: @range[:created_at], remote_account_iban: account.iban)
  end

  def build_statistics
    @transactions = role == 'owner' ? transactions : transactions.where(user_id: current_user.id)
  end

  def invite_statistics
    @invites = Invite.where(account_id: @account.id, user_from_id: current_user.id)
  end
end
