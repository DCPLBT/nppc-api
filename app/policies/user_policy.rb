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
    destroy?
  end
end
