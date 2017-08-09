class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :transactions
  has_many :account_users
  has_many :accounts, through: :account_users
  has_many :roles, through: :account_users

  # ROLES = %i[owner couser observer]

  # def roles=(roles)
  #   roles = [*roles].map(&:to_sym)
  #   self.roles_mask = (roles & ROLES).map { |r| 2**ROLES.index(r) }.inject(0, :+)
  # end

  # def roles
  #   ROLES.reject do |r|
  #     ((roles_mask.to_i || 0) & 2**ROLES.index(r)).zero?
  #   end
  # end

  # def roles=[roles]
  #   @roles = AccountUser.where(user_id: current_user.id, account_id: params:id).Roles.role_id: Role.find_by(name: 'owner').id)
  # end

  # def has_role?(r)
  #   # roles.name.equal?(role)
  #   # @account_user = account_users.find_by(account_id: account.id)
  #   role.name.eql?(r)
  # end

end
