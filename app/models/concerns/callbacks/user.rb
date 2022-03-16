# frozen_string_literal: true

module Callbacks
  module User
    extend ActiveSupport::Concern

    included do
      before_save :assign_defaults
      after_save :assign_individual_to_group
    end

    def assign_defaults
      assign_attributes(
        group_ids: assign_or_create_user_group
      )
    end

    def assign_or_create_user_group # rubocop:disable Metrics/MethodLength
      user_group_ids = []
      roles.each do |role|
        next if role.id == 8

        user_group = Group.find_by(
          user_group_attributes(role)
        ) || Group.create!(
          user_group_attributes(role)
        )
        user_group_ids << user_group.id
      end
      user_group_ids.uniq
    end

    # rubocop:disable Metrics/MethodLength
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
      when 'User', 'ASSR'
        attr.merge!(
          { individual_id: current_user.id }
        )
      else
        attr
      end
    end

    # rubocop:enable Metrics/MethodLength

    def assign_individual_to_group
      return unless roles.ids.include?(8)

      user_group = Group.find_by(role_id: 8, individual_id: id, name: 'User') || Group.create!(
        role_id: 8, individual_id: id, name: 'User'
      )
      ::User.skip_callback(:save, :before, :assign_defaults)
      ::User.skip_callback(:save, :after, :assign_individual_to_group)
      update(group_ids: (group_ids << user_group.id).uniq)
      ::User.set_callback(:save, :before, :assign_defaults)
      ::User.set_callback(:save, :after, :assign_individual_to_group)
    end
  end
end
