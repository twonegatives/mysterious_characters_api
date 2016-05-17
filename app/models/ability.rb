class Ability
  include CanCan::Ability

  def initialize(user)
    case user.try(:role)
    when 'admin'
      can :manage, :all
    when 'user'
      can :read, :all
      can :create, :all
      can [:update, :destroy], Character, user_id: user.id
      can [:destroy], Comment, user_id: user.id
    when 'guest'
      can :read, :all
    end
  end
end
