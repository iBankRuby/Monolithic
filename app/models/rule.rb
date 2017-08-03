class Rule < ApplicationRecord
  has_one :account_user
  has_one :account, through: :account_user

  validates :spending_limit, numericality: {
                                             # less_than_or_equal_to: account.balance,
                                             greater_than_or_equal_to: 0
                                           },
                             allow_nil: true
end
