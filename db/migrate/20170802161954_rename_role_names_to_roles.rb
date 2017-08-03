class RenameRoleNamesToRoles < ActiveRecord::Migration[5.1]
  def change
    rename_table :role_names, :roles
  end
end
