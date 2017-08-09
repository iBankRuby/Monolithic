class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate_user!

  # def current_ability
  #   # current_ability ||= Ability.new(account_user)
  #   # current_ability ||= Ability.new(account_user.last)
  #   # current_ability ||= Ability.new(account_user.last)
  #   # current_ability ||= Ability.new(AccountUser.last)
  # end


end
