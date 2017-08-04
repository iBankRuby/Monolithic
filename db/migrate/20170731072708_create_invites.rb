class CreateInvites < ActiveRecord::Migration[5.1]
  def change
    create_table :invites do |t|
      t.belongs_to :account, index: true
      t.integer :user_from_id, null: false
      t.integer :user_to_id, null: false
      t.boolean :status, default: nil
      t.timestamps
    end
  end
end
