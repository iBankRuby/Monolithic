class Invite < ApplicationRecord
  include InvitesTracking
  include AASM
  has_one :rule, dependent: :destroy
  has_one :invites_tracker, dependent: :destroy
  belongs_to :account

  validate :user_cannot_send_invites_to_himself, :cannot_create_two_same_pending_invites, on: :create
  validates :user_to_email, format: {
    with: /\A([A-Z|a-z|0-9](\.|_){0,1})+[A-Z|a-z|0-9]\@([A-Z|a-z|0-9])+((\.){0,1}[A-Z|a-z|0-9]){2}\.[a-z]{2,3}\z/,
    message: 'Email should be valid'
  }
  validates :user_from_id, numericality: true, presence: true
  # TODO: Sends invite to account once with that validation
  # validates :account_id, uniqueness: { scope: :user_to_id, message: 'You cannot send invite twice' }
  # validates :status, inclusion: { in: [true, false] }, on: :update

  aasm column: 'status' do
    state :pending, initial: true
    state :confirmed
    state :rejected
    state :closed
    state :canceled
    state :expired

    event :confirm do
      transitions from: :pending, to: :confirmed
    end

    event :reject do
      transitions from: :pending, to: :rejected
    end

    event :close do
      transitions from: :confirmed, to: :closed
    end

    event :cancel do
      transitions from: :pending, to: :canceled
    end

    event :expire do
      transitions from: :pending, to: :expired
    end
  end

  def self.create_invite_with_rules(args)
    ActiveRecord::Base.transaction do
      invite = new(args[:invite_params])
      invite.account = Account.friendly.find(args.dig(:invite_params, :account_id))
      invite.create_rule(args[:rule_params])
      invite.create_invites_tracker(invite_id: invite.id, limit: invite.rule.spending_limit)
      invite.send_email && invite.save
      #ExpireInvitesWorker.perform_in(2.minutes, invite.id)
    end
  end

  def confirm_invite(current_user, account_id)
    return false unless may_confirm?
    confirm!
    track_confirming
    account_user = AccountUser.create(user: current_user,
                                      account_id: account_id,
                                      rule_id: rule.id,
                                      role_id: 2)
    account_user.create_limit(reminder: 0.0)
  end

  def reject_invite
    return false unless may_reject?
    rule.really_destroy!
    reject!
    track_rejecting
  end

  # TODO: Do sending with using background jobs.
  def send_email
    user = User.find_by(email: user_to_email)
    if user
      InviteMailer.invite_for_existing_user(user).deliver
    else
      InviteMailer.invite(user_to_email).deliver
    end
  end

  private

  def user_cannot_send_invites_to_himself
    user = User.find_by(email: user_to_email)
    user && user_from_id == user.id && errors.add(:user_from_id, 'You cannot send invites to yourself')
  end

  def cannot_create_two_same_pending_invites
    inv = self.class.find_by(user_to_email: user_to_email, user_from_id: user_from_id, account_id: account_id, status: 'pending')
    inv && errors.add(:user_from_id, 'You cannot send invite twice')
  end
end
