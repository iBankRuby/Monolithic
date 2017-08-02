class CreateRoles < ActiveRecord::Migration[5.1]
  def change
    create_table :roles do |t|
      t.belongs_to :user, index: true
      t.belongs_to :account, index: true
      t.string :role
      t.timestamps
    end
  end
end
