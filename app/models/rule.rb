class Rule < ApplicationRecord
  acts_as_paranoid
  has_one :account_user, dependent: :destroy
  has_one :account, through: :account_user
  # has_one :limit, through: :account_user

  validates :spending_limit, numericality: { greater_than_or_equal_to: 0 }, allow_nil: true
end
