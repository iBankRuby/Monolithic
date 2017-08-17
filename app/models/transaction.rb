class Transaction < ApplicationRecord
  belongs_to :user
  belongs_to :account, -> { with_deleted }
  validates :remote_account_id, :summ, presence: true
  validates :summ, numericality: { greater_than_or_equal_to: 0.01 }

  def self.all_transactions_for(user)
    joins(:account).where(account_id: account.id)
  end
end
