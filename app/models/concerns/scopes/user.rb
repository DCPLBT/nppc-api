# frozen_string_literal: true

module Scopes
  module User
    extend ActiveSupport::Concern

    included do
      scope :search, lambda { |query|
        left_joins(:profile).where(
          "CONCAT_WS(' ', email, username, phone, profiles.employee_id) iLIKE ?", "%#{query&.squish}%"
        )
      }
      scope :filter_by_roles, ->(roles) { joins(:roles).where(roles: { id: roles }) }
      scope :filter_by_status, ->(status) { where(active: status) }
      scope :similar_users, lambda { |role, region_id, district_id, extension_id, company_id|
        users = left_joins(:profile)
        users = users.where(profiles: { region_id: region_id }) if region_id.present?
        users = users.where(profiles: { district_id: district_id }) if district_id.present?
        users = users.where(profiles: { extension_id: extension_id }) if extension_id.present?
        users = users.where(profiles: { company_id: company_id }) if company_id.present?
        users.find_all { |x| x.send("#{role}?") }
      }
    end
  end
end
