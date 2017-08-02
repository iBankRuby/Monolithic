class AddRoleRefToAccountsProducts < ActiveRecord::Migration[5.1]
  def change
    add_reference :accounts_users, :role, foreign_key: true
  end
end
