class ChangeStatusInEcxeedingRequests < ActiveRecord::Migration[5.1]
  def change
    reversible do |dir|
      dir.up do
        change_column :exceeding_requests, :status, :string
      end
      dir.down do
        change_column :exceeding_requests, :status, :boolean , default: nil
      end
    end
  end
end
