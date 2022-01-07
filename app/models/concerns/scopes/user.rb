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
      scope :similar_users, lambda { |role, region_id, district_id, extension_id|
        left_joins(:profile).where(profiles: {
                                     region_id: region_id, district_id: district_id, extension_id: extension_id
                                   }).find_all { |x| x.send("#{role}?") }
      }
    end
  end
end
