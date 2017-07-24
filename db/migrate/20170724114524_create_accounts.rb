class CreateAccounts < ActiveRecord::Migration[5.1]
  def change
    create_table :accounts do |t|
      t.decimal :account_number, precision: 16, scale: 0
      t.integer :user_id

      t.timestamps
    end
  end
end
