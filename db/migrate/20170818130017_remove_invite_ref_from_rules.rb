class RemoveInviteRefFromRules < ActiveRecord::Migration[5.1]
  def change
    remove_reference :rules, :invite
  end
end
