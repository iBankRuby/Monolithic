class Rule < ApplicationRecord
  has_one :role
  has_one :account, through: :role

  validates :spending_limit, numericality: {
                                             # less_than_or_equal_to: account.balance,
                                             greater_than_or_equal_to: 0
                                           }
end
