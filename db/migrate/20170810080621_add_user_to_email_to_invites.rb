class AddUserToEmailToInvites < ActiveRecord::Migration[5.1]
  def change
    add_column :invites, :user_to_email, :string, null: false
  end
end
