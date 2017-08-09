class InvitesController < ApplicationController
  before_action :set_invite, only: %i[destroy update]
  before_action :set_user_to_id, only: :create
  before_action :set_current_user_id, only: :create
  before_action :set_account, only: %i[index create]

  attr_reader :invite, :user_to, :current_user_id, :account

  def index
    @invites = account.invites
    @rule = Rule.new
  end

  def create
    @invite = Invite.new(user_from_id: current_user_id, user_to_id: user_to, account_id: account.id)
    rule = Rule.new(rule_params)
    invite.rule = rule
    if invite.save && rule.save
      redirect_to(:account_invites, notice: 'Invite has been sent.')
    else
      redirect_to :account_invites, notice: 'Invite haven\'t been sent'
    end
  end

  def update
    if invite.update(invite_params)
      account_user = AccountUser.create(user: current_user,
                                        account_id: invite.account_id,
                                        rule_id: invite.rule.id,
                                        role_id: 2)
      account_user.create_limit(reminder: 0.0)
      redirect_to :accounts
    else
      redirect_to :accounts, notice: 'Oops... Something went wrong. Try again.'
    end
  end

  def destroy
    # TODO: Method will return sent invite.
    invite.delete && redirect_to(:accounts)
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

  def rule_params
    params.fetch(:rule).permit(:spending_limit)
  end

end
