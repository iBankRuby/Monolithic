class Account < ApplicationRecord
  belongs_to :user
  has_many :transactions
  has_many :roles
  has_many :users, through: :roles
end
