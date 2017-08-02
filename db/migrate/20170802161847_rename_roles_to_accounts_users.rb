class RenameRolesToAccountsUsers < ActiveRecord::Migration[5.1]
  def change
    rename_table :roles, :accounts_users
  end
end
