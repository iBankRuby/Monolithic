class CreateTransTrackers < ActiveRecord::Migration[5.1]
  def change
    create_table :trans_trackers do |t|
      t.belongs_to :transaction, index: true
      t.datetime :pending_time
      t.float :time_in_pending
      t.datetime :in_process_time
      t.float :time_in_process
      t.datetime :in_approve_time
      t.float :time_in_approve
      t.float :total_time

      t.timestamps
    end
  end
end
