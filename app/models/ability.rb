#
# ability.rb
#
# Class to define the permissions granted to each user role
# Makes use of the CanCan gem

class Ability
  include CanCan::Ability
  def initialize(user)
    user ||= User.new # guest user
    if user.role? :member
      can :read, [Show, ShowDate]
      can :manage, [Foh]
      can [:show, :update], User, :id=> user.id
      can  [:attend, :read], [Training, Workshop]
    end
    if user.role? :committee
      can :read, [Show, ShowDate]
      can  [:attend, :read], [Training, Workshop]
      can :manage, [Foh]
    end
    if user.role? :tech_manager
      can :manage, :all
    end
    if user.role? :production_team
      can :read, [Show, ShowDate]
      can  [:attend, :read], [Training, Workshop]
      can :manage, [Foh]
    end
    if user.role? :drama_studio_manager
      can :read, [Show, ShowDate]
      can  [:attend, :read], [Training, Workshop]
      can :manage, [Foh]
    end
    if user.role? :senior_committee
      can :manage, [Show, ShowDate, Workshop, Foh, Training, User]
    end

  end
end