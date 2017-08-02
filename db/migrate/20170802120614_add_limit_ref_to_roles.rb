class AddLimitRefToRoles < ActiveRecord::Migration[5.1]
  def change
    add_reference :roles, :limit, foreign_key: true
  end
end
