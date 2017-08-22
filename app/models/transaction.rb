class Transaction < ApplicationRecord
  include AASM
  belongs_to :user
  belongs_to :account, -> { with_deleted }
  has_one :trans_tracker, dependent: :destroy
  validates :remote_account_iban, :summ, presence: true
  validates :summ, numericality: { greater_than_or_equal_to: 0.01 }

  aasm column: 'status_from', whiny_transitions: false do
    state :pending, initial: true
    state :in_processing
    state :approved
    state :canceled
    state :in_approval
    state :expired

    event :process do
      transitions from: %i[pending], to: :in_processing
    end

    event :approve do
      transitions from: %i[in_processing], to: :approved
    end

    event :cancel do
      transitions from: %i[pending in_processing in_approval], to: :canceled
    end

    event :need_approval do
      transitions from: %i[in_processing], to: :in_approval
    end

    event :approve_exceeding do
      transitions from: %i[in_approval], to: :approved
    end

    event :expire do
      transitions from: %i[pending in_approval], to: :expired
    end
  end
end

