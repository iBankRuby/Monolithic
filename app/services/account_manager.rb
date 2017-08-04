class AccountManager
  attr_reader :account_id, :user, :account_user
  def initialize(user, account_id)
    @user = user
    @account_id = account_id
  end

  def manage
    grant_access
  end

  private

  def grant_access
    role_type = check_role
    get_users(role_type)
  end

  def check_role
    @account_user ||= AccountUser.find_by(user_id: @user.id, account_id: @account_id)
    role_type = @account_user.role.name
  end

  def get_users(role_type)
    return [].push @account_user if role_type == 'co-user'
    @account_users = AccountUser.where(account_id: @account_id).where.not(limit_id: nil)
  end
end
