class ExceedingRequest < ApplicationRecord
  # has_one :account, through: :account_user
  # has_one :user, through: :account_user

  belongs_to :account_user

  validate :user_can_send_one_exceeding_request_per_period
  validates :amount, numericality: { greater_than_or_equal_to: 0 }

  private

  def user_can_send_one_exceeding_request_per_period
    current_day = Date.today
    ExceedingRequest.where('created_at >= ? and created_at <= ?', current_day, current_day + 1).each do |req|
      req_account_user = req.account_user
      if req_account_user.user == account_user.user && req_account_user.account == account_user.account
        errors.add(:created_at, 'You cannot create request twice in life period of limit')
        break
      end
    end
  end
end
