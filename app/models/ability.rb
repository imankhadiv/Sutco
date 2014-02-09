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
    elsif user.role? :production_team
      can :manage, [Show, Workshop]
    elsif user.role? :senior_committee
      can :manage, [Show, Workshop, Training]
    end
    if user.role? :tech_manager
      can :manage, :all
    elsif user.role? :drama_studio_manager
      can :manage, [Show, Workshop, Training, Calendar]
    elsif user.role? :committee
      can :manage, [Show, Workshop, Calendar]
     # manage products, assets he owns
     #can :manage, Product do |product|
     # product.try(:owner) == user
     #end
    end
  end

end