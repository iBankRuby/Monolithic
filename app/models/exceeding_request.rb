# frozen_string_literal: true

class ExceedingRequest < ApplicationRecord
  include AASM
  belongs_to :account
  belongs_to :user

  validate :user_can_send_one_exceeding_request_per_period, on: :create
  validates :amount, numericality: { greater_than_or_equal_to: 0 }
  # validates :status, inclusion: { in: [true, false] }, on: :update

  aasm column: 'status' do
    state :pending, initial: true
    state :confirmed
    state :rejected
    state :expired

    event :confirm do
      transitions from: :pending, to: :confirmed
    end

    event :reject do
      transitions from: :pending, to: :rejected
    end

    event :expire do
      transitions from: :pending, to: :expired
    end
  end

  def self.exceeding_requests_for(user)
    joins(account: :roles).where(roles: { name: 'owner' }, account_users: { user_id: user.id }, status: 'pending')
  end

  def update_rule
    acc_user = AccountUser.find_by(account_id: account_id, user_id: user_id, role_id: 2)
    acc_user.rule.update(spending_limit: amount)
  end

  private

  def user_can_send_one_exceeding_request_per_period
    current_day = Date.today
    ExceedingRequest.where(created_at: current_day..current_day.next).each do |request|
      if compare_user_with(request.user) && compare_account_with(request.account)
        errors.add(:created_at, 'You cannot create request twice in life period of limit')
        break
      end
    end
  end

  def compare_user_with(request_user)
    request_user == user
  end

  def compare_account_with(request_account)
    request_account == account
  end
end
