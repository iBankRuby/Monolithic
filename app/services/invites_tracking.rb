module InvitesTracking

  def track_confirming
    tracker.time_in_pending = updated_at - created_at
    tracker.cause = 'Invitee confirmed invitation'
    tracker.save
  end

  def track_rejecting
    tracker.time_in_pending = updated_at - created_at
    tracker.cause = 'Invitee rejected invitation'
    tracker.save
  end

  def tracker
    invites_tracker
  end
end