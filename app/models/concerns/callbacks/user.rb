# frozen_string_literal: true

module Callbacks
  module User
    extend ActiveSupport::Concern

    included do
      before_save :assign_defaults
    end

    def assign_defaults
      assign_attributes(
        group_ids: assign_or_create_user_group
      )
    end

    def assign_or_create_user_group
      user_group_ids = []
      roles.each do |role|
        user_group = Group.find_by(
          user_group_attributes(role)
        ) || Group.create!(
          user_group_attributes(role)
        )
        user_group_ids << user_group.id
      end
      user_group_ids
    end

    # rubocop:disable Metrics/MethodLength, Metrics/AbcSize
    def user_group_attributes(role)
      attr = { role_id: role.id, name: role.name }
      case role.name
      when 'ADRC'
        attr.merge!(
          { region_id: region_id }
        )
      when 'MHV'
        attr.merge!(
          { company_id: company_id }
        )
      when 'DAO'
        attr.merge!(
          { region_id: region_id, district_id: district_id }
        )
      when 'EA'
        attr.merge!(
          { region_id: region_id, district_id: district_id, extension_id: extension_id }
        )
      when 'User'
        attr.merge!(
          { region_id: region_id, district_id: district_id, extension_id: extension_id,
            village_id: village_id }
        )
      else
        attr
      end
    end

    # rubocop:enable Metrics/MethodLength, Metrics/AbcSize
  end
end
