class CreateRoleNames < ActiveRecord::Migration[5.1]
  def change
    create_table :role_names do |t|
      t.string :name, uniqueness: true
    end
  end
end
