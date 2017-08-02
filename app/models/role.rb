class Role < ApplicationRecord
  belongs_to :user
  belongs_to :account
  belongs_to :rule, optional: true
  belongs_to :limit, optional: true

  validates :user_id, presence: true
  validates :account_id, presence: true
end
