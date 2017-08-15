class Transaction < ApplicationRecord
  include AASM
  belongs_to :user
  belongs_to :account, -> { with_deleted }
  validates :remote_account_id, :summ, presence: true
  validates :summ, numericality: { greater_than_or_equal_to: 0.01 }

  aasm column: 'status_from' do
    state :pending, initial: true
    state :approved
    state :canceled

    event :approve do
      transitions from: [:pending], to: :approved
    end

    event :cancel do
      transitions from: %i[pending approved], to: :canceled
    end

    event :reset do
      transitions from: %i[approved canceled], to: :pending
    end
  end
end
