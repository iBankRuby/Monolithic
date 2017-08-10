class RemoveUserToIdFromInvites < ActiveRecord::Migration[5.1]
  def change
    remove_column :invites, :user_to_id
  end
end
