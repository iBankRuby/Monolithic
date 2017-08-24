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
    time_in_pending
    tracker.cause = 'Owner canceled invitation'
    tracker.save
  end

  def track_expired
    time_in_pending
    tracker.cause = 'I waited long enough'
    tracker.save
  end

  def track_closing
    total_time
    tracker.cause = 'Owner deleted user from account'
    tracker.save
  end

  def time_in_pending
    tracker.time_in_pending = updated_at - created_at
  end

  def total_time
    tracker.total_time = Time.now - updated_at
  end

  def tracker
    invites_tracker
  end
end