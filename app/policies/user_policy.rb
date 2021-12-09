# frozen_string_literal: true

class UserPolicy < ApplicationPolicy
  def index?
    invite?
  end

  def invite?
    user.admin?
  end

  def show?
    invite?
  end

  def destroy?
    show?
  end

  def update?
    user.admin? || record.id == user.id
  end
end
