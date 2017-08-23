class ExpireInvitesWorker
  include Sidekiq::Worker

  def perform(id)
    # Do something
    invite = Invite.find(id)
    invite.rule.really_destroy! if invite
    invite.expire! if invite.may_expire?
  end
end
