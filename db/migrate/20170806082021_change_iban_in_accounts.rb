class ChangeIbanInAccounts < ActiveRecord::Migration[5.1]
  def up
    remove_column :accounts, :iban, :decimal, precision: 16, scale: 0
    add_column :accounts, :iban, :string, null: 'false'
  end

  def down
    remove_column :accounts, :iban, :string, null: 'false'
    add_column :accounts, :iban, :decimal, precision: 16, scale: 0
  end
end
