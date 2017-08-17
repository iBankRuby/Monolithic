class AddUsersRefToExceedingRequests < ActiveRecord::Migration[5.1]
  def change
    add_reference :exceeding_requests, :user, foreign_key: true
  end
end
