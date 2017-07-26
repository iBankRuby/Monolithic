class Transaction < ApplicationRecord
  belongs_to :user
  belongs_to :account
  validates :remote_account_id, :summ, presence: true
  validates :summ, numericality: { greater_than_or_equal_to: 0.01 }

end
