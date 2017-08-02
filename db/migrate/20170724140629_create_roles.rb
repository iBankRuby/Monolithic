class CreateRoles < ActiveRecord::Migration[5.1]
  def change
    create_table :roles do |t|
      t.belongs_to :user, show: true
      t.belongs_to :account, show: true
      t.string :role
      t.timestamps
    end
  end
end
