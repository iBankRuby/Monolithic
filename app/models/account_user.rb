class AccountUser < ApplicationRecord
  belongs_to :user
  belongs_to :account
  belongs_to :role

  validates :user_id, presence: true
  validates :account_id, presence: true
end
