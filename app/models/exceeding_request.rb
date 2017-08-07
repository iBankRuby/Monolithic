class ExceedingRequest < ApplicationRecord
  belongs_to :account_user

  validate :user_can_send_one_exceeding_request_per_period
  validates :amount, numericality: { greater_than_or_equal_to: 0 }

  def user
    account_user.user
  end

  def account
    account_user.account
  end

  private

  def user_can_send_one_exceeding_request_per_period
    current_day = Date.today
    ExceedingRequest.where('created_at >= ? and created_at <= ?', current_day, current_day + 1).each do |request|
      if compare_user_with(request) && compare_account_with(request)
        errors.add(:created_at, 'You cannot create request twice in life period of limit')
        break
      end
    end
  end

  def compare_user_with(request)
    request.user == user
  end

  def compare_account_with(request)
    request.account == account
  end
end
