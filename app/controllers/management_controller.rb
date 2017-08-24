class ManagementController < ApplicationController
  include InvitesTracking

  before_action :account

  def index
    account
    account_manager = AccountManager.new(current_user, acc_id)
    @account_users = account_manager.manage
  end

  def destroy
    rule = AccountUser.find_by(id: params[:id]).rule
    Invite.find(rule.invite_id).close!
    track_closing
    rule.really_destroy!
    redirect_to account_management_index_path, notice: 'Co-user was successfully deleted.'
  end

  private

  def account
    @account = Account.friendly.find(params[:account_id])
  end

  def acc_id
    @account.id
  end
end
