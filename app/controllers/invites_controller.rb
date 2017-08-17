class InvitesController < ApplicationController
  before_action :set_invite, only: %i[destroy update]
  # before_action :set_user_to_id, only: :create
  before_action :set_current_user_id, only: :create
  before_action :set_account, only: %i[index create]

  attr_reader :invite, :user_to, :current_user_id, :account

  def index
    @invites = account.invites
  end

  def create
    invite_pms = { user_from_id: current_user_id,
                   user_to_email: invite_params[:email],
                   account_id: params[:account_id] }
    if Invite.create_invite_with_rules(invite_params: invite_pms, rule_params: rule_params)
      redirect_to account_invites_url, notice: 'Invite has made.'
    else
      redirect_to :account_invites, alert: 'Invite has not been sent'
    end
  end

  def update
    if invite.update(invite_params)
      account_user = AccountUser.create(user: current_user,
                                        account_id: invite.account_id,
                                        rule_id: invite.rule.id,
                                        # limit_id: Limit.create(reminder: 0.0, movable: params[:movable]).id,
                                        # role_id: Role.find_by(name: 'co-user').id)
                                        role_id: 2)
      account_user.create_limit(reminder: 0.0)
      redirect_to :accounts
    else
      redirect_to :accounts, notice: 'Oops... Something went wrong. Try again.'
    end
  end

  def destroy
    # TODO: Method will return sent invite.
    invite.destroy && redirect_to(:accounts)
  end

  private

  def set_account
    @account = Account.friendly.find(params[:account_id])
  end

  def set_invite
    @invite = Invite.find(params[:id])
  end

  def invite_params
    params.fetch(:invite).permit(:email, :status)
  end

  def rule_params
    params.fetch(:rule).permit(:spending_limit)
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

  # def rule_params
  #  params.fetch(:invite).fetch(:rule).permit(:spending_limit)
  # end
end
