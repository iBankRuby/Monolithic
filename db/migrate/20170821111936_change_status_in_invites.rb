class ChangeStatusInInvites < ActiveRecord::Migration[5.1]
  def change
    reversible do |dir|
      dir.up do
        change_column :invites, :status, :string
      end
      dir.down do
        change_column :invites, :status, :boolean , default: nil
      end
    end
  end
end
