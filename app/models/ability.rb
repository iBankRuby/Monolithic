# The first argument to `can` is the action you are giving the user
# permission to do.
# If you pass :manage it will apply to every action. Other common actions
# here are :read, :create, :update and :destroy.
#
# The second argument is the resource the user can perform the action on.
# If you pass :all it will apply to every resource. Otherwise pass a Ruby
# class of the resource.
#
# The third argument is an optional hash of conditions to further filter the
# objects.
# For example, here the user can only update published articles.
#
#   can :update, Article, :published => true
#
# See the wiki for details:
# https://github.com/CanCanCommunity/cancancan/wiki/Defining-Abilities

class Ability
  include CanCan::Ability

  def initialize(current_user)
    @current_user ||= current_user
    
    # can :manage, Account if @account_user.has_role? 'owner'
    # object of account, not account directly
    can :manage, Account, current_user.accounts do |account|
      # AccountUser.find_by(user_id: current_user.id, account_id: account.id).has_role?('owner')
      account.account_users.find_by(user_id: current_user.id).has_role?('owner')

    end
    #can :read, Account if user.has_role? 'co-user'

    #can :read, :all if user.has_role? :observer
  end
end
