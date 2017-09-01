class AddAccountUsersReferenceToLimits < ActiveRecord::Migration[5.1]
  def change
    add_reference :limits, :account_user, foreign_key: true
  end
end
