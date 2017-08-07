class CreateLimits < ActiveRecord::Migration[5.1]
  def change
    create_table :limits do |t|
      t.integer :reminder, default: 50
      t.boolean :movable, default: false

      t.timestamps
    end
  end
end
