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
      can :read, [Show, ShowDate, ShowRole, Social]
      can :manage, [Foh, Board]
      can [:show, :update, :report], User, :id=> user.id
      can  [:attend, :read], [Training, Workshop]
      can [:show, :create], [RoleApplication]
    end
    if user.role? :committee
      can :read, [Show, ShowRole,ShowDate]
      can [:show, :update, :report], User, :id=> user.id
      can  [:attend, :read], [Training, Workshop]
      can :manage, [Foh, Social, Board]
      can [:show, :create], [RoleApplication]
    end
    if user.role? :tech_manager
      can :read, [Show,ShowDate, ShowRole,Social]
      can :manage, [Workshop, Foh, Training, User, RoleApplication, Board]
    end
    if user.role? :production_team
      can :manage, [Show, ShowDate, Foh, Social, Board, ShowRole]
      can [:show, :update, :report], User, :id=> user.id
      can  [:attend, :read], [Training, Workshop]
      can [:show, :create], [RoleApplication]
    end
    if user.role? :drama_studio_manager
      can :read, [Show, ShowDate, Social]
      can [:show, :update], User, :id=> user.id
      can  [:attend, :read], [Training, Workshop]
      can :manage, [Foh, Board, ShowRole]
      can [:show, :create], [RoleApplication]

    end
    if user.role? :senior_committee
      can :read, [Show,ShowRole,ShowDate]
      can :manage, [Foh, User, Social, Board]
      can [:crud, :attend], [Workshop, Training]
      can [:show, :create, :report], [RoleApplication]
    end

  end
end