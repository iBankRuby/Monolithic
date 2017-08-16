class AddRemoteBalanceToTransactions < ActiveRecord::Migration[5.1]
  def up
    add_column :transactions, :balance_after, :float
    add_column :transactions, :remote_balance_after, :float
    remove_column :transactions, :checkout_from, :datetime
    remove_column :transactions, :checkout_to, :datetime
  end

  def down
    add_column :transactions, :checkout_to, :datetime
    add_column :transactions, :checkout_from, :datetime
    remove_column :transactions, :remote_balance_after, :float
    remove_column :transactions, :balance_after, :float
  end
end
