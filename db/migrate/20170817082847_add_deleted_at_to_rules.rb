class AddDeletedAtToRules < ActiveRecord::Migration[5.1]
  def change
    add_column :rules, :deleted_at, :datetime
    add_index :rules, :deleted_at
  end
end
