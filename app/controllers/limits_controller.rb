class LimitsController < ApplicationController
  # before_action :set_limit
  def index
    @limits = Limit.all
  end

  def show
  end
  # def set_invite
  #   @limits = Limits.all
  # end
end
