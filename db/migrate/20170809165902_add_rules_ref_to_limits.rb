class AddRulesRefToLimits < ActiveRecord::Migration[5.1]
  def change
    add_reference :limits, :rules, foreign_key: true
  end
end
