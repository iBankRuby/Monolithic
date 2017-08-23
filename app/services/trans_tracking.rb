module TransTracking

  def track_process
    tracker.in_process_time = last_update
    tracker.time_in_pending = time_in_previous_status(tracker.in_process_time, tracker.pending_time)
    tracker.save
  end

  def track_in_approve
    tracker.in_approve_time = last_update
    tracker.time_in_process = time_in_previous_status(tracker.in_approve_time, tracker.in_process_time)
    tracker.save
  end

  def track_approve_exceeding
    tracker.time_in_approve = time_in_previous_status(last_update, tracker.in_approve_time)
    set_total_time
  end

  def time_in_previous_status(new_time, pre_time)
    new_time - pre_time
  end

  def set_total_time
    tracker.total_time = last_update - tracker.pending_time
    tracker.save
  end

  def last_update
    transaction.updated_at
  end

  def tracker
    transaction.trans_tracker
  end

  
end