class ExceedingRequest < ApplicationRecord
  belongs_to :account_user

  validate :user_can_send_one_exceeding_request_per_period, on: :create
  validates :amount, numericality: { greater_than_or_equal_to: 0 }
  validates :status, inclusion: { in: [true, false] }, on: :update

  def user
    account_user.user
  end

  def account
    account_user.account
  end

  def self.exceeding_requests_for(user)
    joins(:account_user)
      .joins('INNER JOIN roles ON roles.id = account_users.role_id')
      .where('account_users.user_id' => user.id,
             'roles.name' => 'owner',
             'status' => nil)
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
