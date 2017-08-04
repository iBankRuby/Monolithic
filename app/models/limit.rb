class Limit < ApplicationRecord
  has_one :account_user
  has_one :account, through: :account_user

  validates :reminder, numericality: { greater_than_or_equal_to: 0 }
end
