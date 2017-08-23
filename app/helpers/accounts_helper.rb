module AccountsHelper
  def accs
    @accounts ||= current_user.accounts.without_deleted
  end

  def check_couser_limit_remainder
    @couser_remainder ||= @account.account_users.find_by(user_id: current_user.id).limit.reminder
  end
end
