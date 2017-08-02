class Invite < ApplicationRecord
  validate :user_to_must_exits, :user_cannot_send_invites_to_himself
  validates :user_from_id, :user_to_id, numericality: true, presence: true
  validates :user_from_id, uniqueness: { scope: %i[user_to_id account_id], message: 'two invites on one acc' }
  belongs_to :account, dependent: :destroy

  # def confirmed?
  #   status
  # end

  # def expired?
  #   (created_at + 3600 * 24 * 3) < Time.now
  # end

  private

  def user_to_must_exits
    User.exists?(user_to_id) || errors.add(:user_to_id, 'You can send invite just to existing user.')
  end

  def user_cannot_send_invites_to_himself
    user_from_id == user_to_id && errors.add(:user_from_id, 'You cannot send invites to yourself')
  end
end
