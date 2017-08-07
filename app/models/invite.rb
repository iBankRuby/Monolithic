class Invite < ApplicationRecord
  validate :user_to_must_exits, :user_cannot_send_invites_to_himself
  validates :user_from_id, :user_to_id, numericality: true, presence: true
  validates :account_id, uniqueness: { scope: :user_to_id, message: 'You cannot send invite twice' }
  validates :status, presence: true, on: :update
  belongs_to :account
  belongs_to :account, dependent: :destroy


  private

  def user_to_must_exits
    User.exists?(user_to_id) || errors.add(:user_to_id, 'You can send invite just to existing user.')
  end

  def user_cannot_send_invites_to_himself
    user_from_id == user_to_id && errors.add(:user_from_id, 'You cannot send invites to yourself')
  end
end
