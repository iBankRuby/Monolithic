class AddHashIdToAccounts < ActiveRecord::Migration[5.1]
  def up
   add_column :accounts, :hash_id, :string, index: true
   Account.all.each{|m| m.set_hash_id; m.save}
  end
  def down
   remove_column :accounts, :hash_id, :string
  end
end
