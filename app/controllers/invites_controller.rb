class InvitesController < ApplicationController
  before_action :set_invite, only: %i[destroy confirm reject]
  # before_action :set_user_to_id, only: :create
  before_action :set_current_user_id, only: :create
  before_action :set_account, only: %i[index create]

  attr_reader :invite, :user_to, :current_user_id, :account

  def index
    @invites = account.invites.where(status: 'pending')
  end

  def create
    invite_pms = { user_from_id: current_user_id,
                   user_to_email: invite_params[:email],
                   account_id: params[:account_id] }
    if Invite.create_invite_with_rules(invite_params: invite_pms, rule_params: rule_params)
      redirect_to :account_invites, notice: 'Invite has made.'
    else
      redirect_to :account_invites, alert: 'Invite has not been sent'
    end
  end

  def confirm
    if invite.confirm_invite(current_user, params[:account_id])
      redirect_to :accounts
    else
      redirect_to :accounts, notice: 'Oops... Something went wrong. Try again.'
    end
  end

  def reject
    if invite.reject_invite
      redirect_to :accounts
    else
      redirect_to :accounts, notice: 'Oops... Something went wrong. Try again.'
    end
  end

  def destroy
    # TODO: Method will return sent invite.
    invite.rule.really_destroy! && invite.destroy && redirect_to(:accounts)
  end

  private

  def set_account
    @account = Account.friendly.find(params[:account_id])
  end

  def set_invite
    @invite = Invite.find(params[:id] || params[:invite_id])
  end

  def invite_params
    params.fetch(:invite).permit(:email)
  end

  def rule_params
    params.dig(:invite, :rule).permit(:spending_limit)
  end

  def set_user_to_id
    email = invite_params[:email]
    user = User.find_by(email: email)
    if email.blank?
      redirect_to account_invites_url, notice: 'Field should\'t be blank'
    elsif user.nil?
      redirect_to account_invites_url, notice: '@mail not found'
    else
      @user_to = user.id
    end
  end

  def set_current_user_id
    @current_user_id = current_user.id
  end
end
