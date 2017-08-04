class AddSpendingLimitToRules < ActiveRecord::Migration[5.1]
  def change
    add_column :rules, :spending_limit, :decimal, precision: 10, scale: 4
  end
end
