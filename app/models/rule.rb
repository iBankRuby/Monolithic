# frozen_string_literal: true

class Rule < ApplicationRecord
  has_one :account_user
  has_one :account, through: :account_user

  validates :spending_limit, numericality: {
    greater_than_or_equal_to: 0
  },
                             allow_nil: true
end
