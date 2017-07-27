class Role < ApplicationRecord
  belongs_to :user
  belongs_to :account
  
  validates :user_id, presence: true
  validates :account_id, presence: true
end
