class RenameRolesToAccountsUsers < ActiveRecord::Migration[5.1]
  def change
    rename_table :roles, :account_users
  end
end
