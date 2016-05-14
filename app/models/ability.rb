class Ability
  include CanCan::Ability

  def initialize(user)
    case user.role
    when 'admin'
      can :manage, :all
    when 'user'
      can :read, :all
    when 'guest'
      can :read, :all
    end
  end
end
