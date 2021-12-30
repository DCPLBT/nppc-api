# frozen_string_literal: true

class UserPopulator < BasePopulator
  attr_accessor :q, :status, :roles, :region_id, :district_id, :extension_id

  def run
    users
      .yield_self(&method(:role_filters))
      .yield_self(&method(:status_filters))
      .yield_self(&method(:region_filters))
      .yield_self(&method(:district_filters))
      .yield_self(&method(:extension_filters))
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

  def extension_filters(users)
    return users unless extension_id.present?

    users.joins(:profile).where(profiles: { extension_id: extension_id })
  end

  def district_filters(users)
    return users unless district_id.present?

    users.joins(:profile).where(profiles: { district_id: district_id })
  end

  def region_filters(users)
    return users unless region_id.present?

    users.joins(:profile).where(profiles: { region_id: region_id })
  end
end
