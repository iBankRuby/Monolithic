class AddTransTrackerToTransactions < ActiveRecord::Migration[5.1]
  def change
    add_reference :transactions, :trans_tracker, foreign_key: true
  end
end
