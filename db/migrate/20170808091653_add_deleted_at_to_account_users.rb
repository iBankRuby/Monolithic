class AddDeletedAtToAccountUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :account_users, :deleted_at, :datetime
    add_index :account_users, :deleted_at
  end
end
