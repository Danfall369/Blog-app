class Ability
  include CanCan::Ability

  def initialize(user)
    user || User.new

    can :manage, :all if user.role == 'admin'

    return unless user.role == 'user'

    can :read, :all
  end
end
