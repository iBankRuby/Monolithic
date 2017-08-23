module AccountsHelper
  def accs
    @accounts ||= current_user.accounts
  end
end