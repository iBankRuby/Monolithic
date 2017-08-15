class AddAasmToTransactions < ActiveRecord::Migration[5.1]
  def up
    remove_column :transactions, :status_from, default: true
    add_column :transactions, :status_from, :string
    rename_column :transactions, :remote_account_id, :remote_account_iban
    add_column :transactions, :reminder, :integer
  end
  def down
    remove_column :transactions, :reminder, :integer
    rename_column :transactions, :remote_account_iban, :remote_account_id
    remove_column :transactions, :status_from, :string
    add_column :transactions, :status_from, default: true
  end
end
