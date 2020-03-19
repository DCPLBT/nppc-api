class UserPolicy < ApplicationPolicy
  def index?
    invite?
  end

  def invite?
    user.admin?
  end

  def status?
    user.admin?
  end

  def show?
    invite?
  end

  def destroy?
    show?
  end

  def update?
    destroy?
  end

  class Scope < Scope
    def resolve
      scope.all
    end
  end
end
