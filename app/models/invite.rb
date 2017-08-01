class Invite < ApplicationRecord
  validate :user_to_must_exits, :user_cannot_send_invites_to_himself, :invite_have_already_sent
  validates :user_from_id, :user_to_id, numericality: true, presence: true
  belongs_to :account

  def confirmed?
    status
  end

  def expired?
    (created_at + 3600 * 24 * 3) < Time.now
  end

  private

  def user_to_must_exits
    User.exists?(user_to_id) || errors.add(:user_to_id, 'You can send invite just to existing user.')
  end

  def user_cannot_send_invites_to_himself
    user_from_id == user_to_id && errors.add(:user_from_id, 'You cannot send invites to yourself')
  end

  def invite_have_already_sent
    invite = Invite.find_by(user_from_id: user_from_id, user_to_id: user_to_id)
    unless invite.nil? || invite.confirmed? || invite.expired?
      errors.add(:invite, 'You cannot send invite twice before it is rejected')
    end
  end
end
