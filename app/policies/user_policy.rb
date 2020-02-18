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

  class Scope < Scope
    def resolve
      scope.all
    end
  end
end
