class CreateInvitesTrackers < ActiveRecord::Migration[5.1]
  def change
    create_table :invites_trackers do |t|
      t.belongs_to :invite, index: true
      t.float :limit
      t.datetime :pending_time
      t.float :time_in_pending
      t.float :total_time
      t.string :cause

      t.timestamps
    end
  end
end
