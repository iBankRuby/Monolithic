module AccountsHelper
  def accs
    @accounts = current_user.accounts.without_deleted
  end
end
