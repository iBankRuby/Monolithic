class RenameColumnReminderToRemainderForLimits < ActiveRecord::Migration[5.1]
  def change
    rename_column :limits, :reminder, :remainder
  end
end
