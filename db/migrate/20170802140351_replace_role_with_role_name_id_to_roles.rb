class ReplaceRoleWithRoleNameIdToRoles < ActiveRecord::Migration[5.1]
  def change
    remove_column :roles, :role, :string
  end
end
