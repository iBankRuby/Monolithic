class ExpireInvitesWorker
  include Sidekiq::Worker
  include InvitesTracking

  def perform(id)
    # Do something
    invite = Invite.find(id)
    return unless invite
    invite.expire! && invite.rule.really_destroy! if invite.may_expire?
    # track_expired
  end
end
