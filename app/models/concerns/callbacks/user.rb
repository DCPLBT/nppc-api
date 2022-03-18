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
      else
        attr
      end
    end

    # rubocop:enable Metrics/MethodLength

    def assign_individual_to_group # rubocop:disable Metrics/MethodLength,Metrics/AbcSize
      return unless (roles.ids & [7, 8]).any?

      gid = []
      roles.each do |r|
        attr = { role_id: r.id, individual_id: id, name: r.name }
        attr.merge!(region_id: region_id, district_id: district_id, extension_id: extension_id) if assr?
        gid << (Group.find_by(attr) || Group.create!(attr)).id
      end
      ::User.skip_callback(:save, :before, :assign_defaults)
      ::User.skip_callback(:save, :after, :assign_individual_to_group)
      update(group_ids: gid.uniq)
      ::User.set_callback(:save, :before, :assign_defaults)
      ::User.set_callback(:save, :after, :assign_individual_to_group)
    end
  end
end
