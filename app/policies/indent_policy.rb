# frozen_string_literal: true

class IndentPolicy < ApplicationPolicy
  def create?
    user.dao? || user.user? || user.ea?
  end
end
