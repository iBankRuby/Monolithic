class Ability
  include CanCan::Ability

  def initialize(user)
    @current_user ||= user

    abilities_to_owner     if user.has_role? :owner
    abilities_to_co_user   if user.has_role? :'co-user'
    abilities_to_read_only if user.has_role? :read_only
  end

  private

  def abilities_to_owner
    can :manage, Account
  end

  def abilities_to_co_user
    can :read, Account
  end

  def abilities_to_read_only
    can :read, Account
  end
end
