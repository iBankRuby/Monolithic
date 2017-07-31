class InvitesController < ApplicationController
  before_action :set_invite, only: :destroy

  def index
    @invites = Invite.where(user_from_id: current_user.id)
  end

  def create
    @invite = Invite.new(invite_params)
    @invite.save! && redirect_to(:index, notice: 'Invite have created.')
    redirect_to :index, notice: 'Invite haven\'t been made'
  end

  def destroy
    @invite.delete
  end

  private

  def set_invite
    @invite = Invite.find(params[:id])
  end

  def invite_params
    params.fetch(:invite).permit(:user_to_id, :user_from_id)
  end
end
