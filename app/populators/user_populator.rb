# frozen_string_literal: true

class UserPopulator < BasePopulator
  attr_accessor :q, :status, :roles, :departments, :grades, :sections

  def run
    users
      .yield_self(&method(:role_filters))
      .yield_self(&method(:status_filters))
      .public_send(:search, q)
  end

  private

  def role_filters(users)
    return users unless roles&.any?(&:present?)

    users.filter_by_roles(roles)
  end

  def status_filters(users)
    return users unless status.present?

    users.filter_by_status(determine_boolean(status))
  end

  def users
    @users ||= User.includes(
      :roles,
      :profile,
      :photo,
      :roles_users
    )
  end
end
