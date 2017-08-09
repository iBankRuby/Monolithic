class AccountUser < ApplicationRecord
  belongs_to :user
  belongs_to :account
  belongs_to :role
  belongs_to :rule, optional: true

  validates :user_id, presence: true
  validates :account_id, presence: true

  def has_role?(r)
    # roles.name.equal?(role)
    # @account_user = account_users.find_by(account_id: account.id)
    #ENUM roles
    # equal?
    # role.name.eql?(r)
    role.name==r

  end

end
