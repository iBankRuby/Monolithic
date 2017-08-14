class AccountUser < ApplicationRecord
  belongs_to :user
  belongs_to :account
  belongs_to :role
  belongs_to :rule, optional: true
  belongs_to :limit, optional: true

  validates :user_id, presence: true
  validates :account_id, presence: true
end
