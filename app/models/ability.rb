#
# ability.rb
#
# Class to define the permissions granted to each user role
# Makes use of the CanCan gem

class Ability
  include CanCan::Ability
  def initialize(user)
    user ||= User.new # guest user
    alias_action :create, :read, :update, :destroy, :to => :crud

    if user.role? :member
      can :read, [Show, ShowDate, Social]
      can :manage, [Foh, RoleApplication, Board]
      can [:show, :update], User, :id=> user.id
      can  [:attend, :read], [Training, Workshop]
    end
    if user.role? :committee
      can :read, [Show, ShowDate]
      can [:show, :update], User, :id=> user.id
      can  [:attend, :read], [Training, Workshop]
      can :manage, [Foh, Social, RoleApplication, Board]
    end
    if user.role? :tech_manager
      can :read, [Show,ShowDate, Social]
      can :manage, [Workshop, Foh, Training, User, RoleApplication, Board]
    end
    if user.role? :production_team
      can :manage, [Show, ShowDate, Foh, Social, RoleApplication, Board]
      can [:show, :update], User, :id=> user.id
      can  [:attend, :read], [Training, Workshop]
    end
    if user.role? :drama_studio_manager
      can :read, [Show, ShowDate, Social]
      can [:show, :update], User, :id=> user.id
      can  [:attend, :read], [Training, Workshop]
      can :manage, [Foh, RoleApplication, Board]
    end
    if user.role? :senior_committee
      can :read, [Show,ShowDate]
      can :manage, [Foh, User, Social, RoleApplication, Board]
      can [:crud, :attend], [Workshop, Training]
    end

  end
end