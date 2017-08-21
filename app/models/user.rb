class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  # devise :confirmable

  has_many :transactions
  has_many :account_users
  has_many :accounts, through: :account_users
  has_many :roles, through: :account_users

  attr_reader :role

  def role_for(account)
    @role = account_users.find_by(account_id: account.id).role
  end

  def has_role?(rol)
    role.name.to_sym == rol
  end
end
