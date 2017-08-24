class ExpireInvitesWorker
  include Sidekiq::Worker
  include InvitesTracking

  def perform(id)
    # Do something
    invite = Invite.find(id)
    invite.rule.really_destroy! if invite
    invite.expire! if invite.may_expire?
    track_expired
  end
end
