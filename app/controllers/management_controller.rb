class ManagementController < ApplicationController
  include InvitesTracking

  before_action :account

  def index
    account
    account_manager = AccountManager.new(current_user, acc_id)
    @account_users = account_manager.manage
  end

  def destroy
    @role = account.account_users.find_by(user_id: current_user.id).role.name
    rule = AccountUser.find_by(id: params[:id]).rule
    @invite = Invite.find(rule.invite_id)
    track_closing
    @invite.close!
    rule.really_destroy!
    if @role == 'owner'
      redirect_to account_management_index_path, notice: 'Co-user was successfully deleted.'
    else
      redirect_to accounts_path, notice: "You left #{account.iban}"
    end
  end

  private

  def account
    @account = Account.friendly.find(params[:account_id])
  end

  def acc_id
    @account.id
  end
end
