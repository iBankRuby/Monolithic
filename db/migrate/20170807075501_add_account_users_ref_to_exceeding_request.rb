class AddAccountUsersRefToExceedingRequest < ActiveRecord::Migration[5.1]
  def change
    add_reference :exceeding_requests, :account_user, foreign_key: true
  end
end
