class AddStatusToExceedingRequests < ActiveRecord::Migration[5.1]
  def change
    add_column :exceeding_requests, :status, :boolean
  end
end
