class AddCauseToTransTracker < ActiveRecord::Migration[5.1]
  def change
    add_column :trans_trackers, :cause, :string
  end
end
