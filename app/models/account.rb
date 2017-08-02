class Account < ApplicationRecord
  has_many :transactions
  has_many :roles
  has_many :users, through: :roles
  has_many :limits, through: :roles
  has_many :invites
  has_many :rules, through: :roles
end
