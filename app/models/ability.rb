class Ability
  include CanCan::Ability

  def initialize(user)
    alias_action :read, :create, :update, :destroy, to: :crud
    @current_user ||= user

    abilities_to_owner     if user.has_role? :owner
    abilities_to_co_user   if user.has_role? :'co-user'
    abilities_to_read_only if user.has_role? :read_only
  end

  private

  def abilities_to_owner
    can :crud, Account
    can :check_account_balance, Account
    can :can_replenish, Account
    can :can_income, Transaction
  end

  def abilities_to_co_user
    can :read, Account
    can :check_own_remainder, Account
    can :do_exceeding_request, Account
  end

  def abilities_to_read_only
    can :read, Account
  end
end
