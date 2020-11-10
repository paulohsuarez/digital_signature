class Ability
  include CanCan::Ability

  def initialize(user)
    alias_action :create, :read, :update, to: :perms_without_delete
    user ||= User.new 
    if user.perfil == 'Funcionario'
      can :manage, :all
    elsif user.perfil == 'Cliente'
        can :read, :all
    end
  end
end
