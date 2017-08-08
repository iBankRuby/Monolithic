class AccountManager
  attr_reader :account_id, :user, :account_users
  def initialize(user, account_id)
    @user = user
    @account_id = account_id
  end

  def manage
    get_response
  end

  private

  def get_response
    role_type = check_role
    build_response(role_type)
  end

  def check_role
    @account_users ||= AccountUser.where(user_id: @user.id, account_id: @account_id)
    @account_users[0].role.name
  end

  def build_response(role_type)
    response = [].push role_type
    response.push acc_usrs role_type
  end

  def acc_usrs(role_type)
    return @account_users if role_type == 'co-user'
    @account_users = AccountUser.where(account_id: @account_id).where.not(limit_id: nil)
  end
end
