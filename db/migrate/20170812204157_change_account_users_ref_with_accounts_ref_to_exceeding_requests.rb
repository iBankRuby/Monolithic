class ChangeAccountUsersRefWithAccountsRefToExceedingRequests < ActiveRecord::Migration[5.1]
  def change
    remove_reference :exceeding_requests, :account_user
    add_reference :exceeding_requests, :account, foreign_key: true
  end
end
