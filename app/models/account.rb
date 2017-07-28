class Account < ApplicationRecord
  has_many :transactions
  has_many :roles
  has_many :users, through: :roles
end
