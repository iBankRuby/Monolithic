class LimitsController < ApplicationController
  def index
    @limits = Limit.all
  end

  def show
    @role = AccountUser.where(user_id: current_user.id, role_id: Role.find_by(name: 'co-user'))
  end
end
