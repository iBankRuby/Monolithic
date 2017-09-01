module InvitesTracking

  def track_confirming
    time_in_pending
    tracker.cause = 'Invitee confirmed invitation'
    tracker.save
  end

  def track_rejecting
    time_in_pending
    tracker.cause = 'Invitee rejected invitation'
    tracker.save
  end

  def track_cancel
    invite.time_in_pending
    invite.tracker.cause = 'Owner canceled invitation'
    invite.tracker.save
  end

  def track_expired
    invite.total_time
    invite.tracker.cause = 'I waited long enough'
    invite.tracker.save
  end

  def track_closing
    @invite.total_time
    @invite.tracker.cause = @role == 'owner' ? 'Owner deleted user from account' : 'User left the account'
    @invite.tracker.save
  end

  def time_in_pending
    tracker.time_in_pending = Time.now - created_at
  end

  def total_time
    tracker.total_time = Time.now - updated_at
  end

  def tracker
    invites_tracker
  end
end