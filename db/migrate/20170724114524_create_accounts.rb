class CreateAccounts < ActiveRecord::Migration[5.1]
  def change
    create_table :accounts do |t|
      t.decimal :iban, precision: 16, scale: 0
      t.float :balance
      t.timestamps
    end
  end
end
