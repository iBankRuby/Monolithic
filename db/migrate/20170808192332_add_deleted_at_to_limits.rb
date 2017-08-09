class AddDeletedAtToLimits < ActiveRecord::Migration[5.1]
  def change
    add_column :limits, :deleted_at, :datetime
    add_index :limits, :deleted_at
  end
end
