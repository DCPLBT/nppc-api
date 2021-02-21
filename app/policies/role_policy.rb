# frozen_string_literal: true

class RolePolicy < ApplicationPolicy
  def create?
    user.admin?
  end

  def update?
    create?
  end

  def destroy?
    create?
  end
end
