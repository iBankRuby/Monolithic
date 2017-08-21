class ExpireInvitesWorker
  include Sidekiq::Worker

  def perform(id)
    # Do something
    invite = Invite.find(id)
    invite.expire! if invite.may_expire?
  end
end
