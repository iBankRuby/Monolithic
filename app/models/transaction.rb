# frozen_string_literal: true

class Transaction < ApplicationRecord
  include AASM
  belongs_to :user
  belongs_to :account, -> { with_deleted }
  validates :remote_account_iban, :summ, presence: true
  validates :summ, numericality: { greater_than_or_equal_to: 0.01 }

  aasm column: 'status_from' do
    state :pending, initial: true
    state :approved
    state :canceled
    state :in_approval

    event :approve do
      transitions from: %i[pending], to: :approved
    end

    event :cancel do
      transitions from: %i[pending approved in_approval], to: :canceled
    end

    event :need_approval do
      transitions from: %i[pending approved], to: :in_approval
    end

    event :approve_exceeding do
      transitions from: %i[in_approval], to: :approved
    end

    event :reset do
      transitions from: %i[approved canceled in_approval], to: :pending
    end
  end
end
