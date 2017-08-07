class AccountUser < ApplicationRecord
  has_many :exceeding_requests, dependent: :destroy
  belongs_to :user
  belongs_to :account
  belongs_to :role
  belongs_to :rule, optional: true

  validates :user_id, presence: true
  validates :account_id, presence: true
end
