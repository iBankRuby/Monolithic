class CreateLimits < ActiveRecord::Migration[5.1]
  def change
    create_table :limits do |t|
      t.belongs_to :role, index: true
      t.integer :limit, null: false, default: 50
      t.integer :reminder, default: 50
      t.boolean :movable, default: false

      t.timestamps
    end
  end
end
