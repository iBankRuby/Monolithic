class Invite < ApplicationRecord
  belongs_to :account

  validate :user_cannot_send_invites_to_himself
  validates :user_to_email, format: {
    with: /\A([A-Z|a-z|0-9](\.|_){0,1})+[A-Z|a-z|0-9]\@([A-Z|a-z|0-9])+((\.){0,1}[A-Z|a-z|0-9]){2}\.[a-z]{2,3}\z/,
    message: 'Email should be valid'
  }
  validates :user_from_id, :user_to_id, numericality: true, presence: true
  # TODO: Sends invite to account once with that validation
  # validates :account_id, uniqueness: { scope: :user_to_id, message: 'You cannot send invite twice' }
  validates :status, inclusion: { in: [true, false] }, on: :update

  def self.create_invite_with_rules(args)
    invite = new(args[:invite_params])
    rules = Rule.new(args[:rule_params])

    invite.send_invite
    invite.save && rules.save
  end

  # TODO: Send with using background jobs.
  def send_invite
    user = User.find_by(user_to_email: email)
    if user
      InviteMailer.deliver_invite_for_existing_user(user)
    else
      InviteMailer.deliver_invite(email)
    end
  end

  private

  def user_cannot_send_invites_to_himself
    user_from_id == user_to_id && errors.add(:user_from_id, 'You cannot send invites to yourself')
  end
end
