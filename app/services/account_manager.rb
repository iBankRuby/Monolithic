class AccountManager
  attr_reader :account_id, :user, :account_users, :role

  def initialize(user, acc_id)
    @user = user
    @account_id = acc_id
  end

  def manage
    prepare_response
  end

  private

  def prepare_response
    @account_users ||= account_users_by_account_id
    @role = check_role
    build_response
  end

  def check_role
    account_user = account_users.find_by(user_id: user.id)
    account_user.role.name
  end

  def build_response
    response = { role: role }
    @account_users = if role.eql?('co-user')
                       account_users.where(user_id: user.id)
                     else
                       account_users.where.not(role_id: 1)
                     end
    response.merge!(account_users: account_users)
  end

  def account_users_by_account_id
    AccountUser.where(account_id: account_id)
  end
end
