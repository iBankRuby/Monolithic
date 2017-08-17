class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  devise :confirmable

  has_many :transactions
  has_many :account_users
  has_many :accounts, through: :account_users
  has_many :roles, through: :account_users
end
