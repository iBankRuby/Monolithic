class AddRuleRefToInvites < ActiveRecord::Migration[5.1]
  def change
  	add_reference :rules, :invite, foreign_key: true
  end
end
