class LimitsController < ApplicationController
  def index
    @limits = Limit.all
  end

  def show
    @role = Role.where(user_id: current_user.id, role: 'co-user')
  end
end
