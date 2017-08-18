class AddRulesRefToInvites < ActiveRecord::Migration[5.1]
  def change
    add_reference :invites, :rule, foreign_key: true
  end
end
