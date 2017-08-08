# frozen_string_literal: true

class Limit < ApplicationRecord
  has_one :account_user
  has_one :account, through: :account_user

  validates :remainder, numericality: { greater_than_or_equal_to: 0 }
end
