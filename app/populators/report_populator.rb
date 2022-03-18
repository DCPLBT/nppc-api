# frozen_string_literal: true

class ReportPopulator < BasePopulator # rubocop:disable Metrics/ClassLength
  DISTRIBUTED_TYPE = %w[self individual].freeze

  attr_accessor :product_type_id, :product_id, :received, :submitted, :type, :region_id, :district_id,
                :extension_id, :company_id, :distributed_type, :distributed_by, :village, :sale_agent_id

  def run # rubocop:disable Metrics/MethodLength, Metrics/AbcSize
    line_items
      .yield_self { |line_items| filter_by_date_range(line_items) }
      .yield_self { |line_items| filter_by_product_type(line_items) }
      .yield_self { |line_items| filter_by_product(line_items) }
      .yield_self { |line_items| filter_by_received(line_items) }
      .yield_self { |line_items| filter_by_submitted(line_items) }
      .yield_self { |line_items| filter_by_region(line_items) }
      .yield_self { |line_items| filter_by_district(line_items) }
      .yield_self { |line_items| filter_by_extension(line_items) }
      .yield_self { |line_items| filter_by_company(line_items) }
      .yield_self { |line_items| filter_by_distributed_type(line_items) }
      .yield_self { |line_items| filter_by_village(line_items) }
      .distinct
      .yield_self { |line_items| group_by_product(line_items) }
  end

  def overall
    line_items
      .yield_self { |line_items| filter_by_date_range(line_items) }
      .yield_self { |line_items| filter_by_product_type(line_items) }
      .yield_self { |line_items| filter_by_product(line_items) }
      .yield_self { |line_items| filter_by_distributed_by(line_items) }
      .distinct
  end

  private

  def line_items
    @line_items ||= LineItem.includes(
      :product_type, :product
    ).where(itemable_type: type)
  end

  # Filters list
  def filter_by_product_type(line_items)
    return line_items unless product_type_id.present?

    line_items.filter_by_product_type(product_type_id)
  end

  def filter_by_product(line_items)
    return line_items unless product_id.present?

    line_items.filter_by_product(product_id)
  end

  def filter_by_received(line_items)
    return line_items unless received.present? || determine_boolean(received)

    received_line_items(line_items)
  end

  def filter_by_submitted(line_items)
    return line_items unless submitted.present? || determine_boolean(submitted)

    submitted_line_items(line_items)
  end

  def filter_by_region(line_items)
    return line_items unless region_id.present?

    line_items.joins(
      "INNER JOIN #{type.underscore.pluralize} ON #{type.underscore.pluralize}.id = line_items.itemable_id AND "\
      "line_items.itemable_type='#{type}'"
    ).where("#{type.underscore.pluralize}": { region_id: region_id })
  end

  def filter_by_district(line_items)
    return line_items unless district_id.present?

    line_items.joins(
      "INNER JOIN #{type.underscore.pluralize} ON #{type.underscore.pluralize}.id = line_items.itemable_id AND "\
      "line_items.itemable_type='#{type}'"
    ).where("#{type.underscore.pluralize}": { district_id: district_id })
  end

  def filter_by_extension(line_items)
    return line_items unless extension_id.present?

    line_items.joins(
      "INNER JOIN #{type.underscore.pluralize} ON #{type.underscore.pluralize}.id = line_items.itemable_id AND "\
      "line_items.itemable_type='#{type}'"
    ).where("#{type.underscore.pluralize}": { extension_id: extension_id })
  end

  # rubocop:disable Metrics/AbcSize
  def filter_by_village(line_items)
    return line_items unless village.present? && type.eql?('Distribution')

    line_items.joins(
      "INNER JOIN #{type.underscore.pluralize} ON #{type.underscore.pluralize}.id = line_items.itemable_id AND "\
      "line_items.itemable_type='#{type}'"
    ).where("#{type.underscore.pluralize}": { village_id: village_id })
  end

  def filter_by_company(line_items)
    return line_items unless company_id.present? && type.eql?('Distribution')

    line_items.joins(
      "INNER JOIN #{type.underscore.pluralize} ON #{type.underscore.pluralize}.id = line_items.itemable_id AND "\
      "line_items.itemable_type='#{type}'"
    ).where("#{type.underscore.pluralize}": { company_id: company_id })
  end

  def filter_by_distributed_type(line_items)
    return line_items unless distributed_type.present? && type.eql?('Distribution')

    line_items.joins(
      "INNER JOIN #{type.underscore.pluralize} ON #{type.underscore.pluralize}.id = line_items.itemable_id AND "\
      "line_items.itemable_type='#{type}'"
    ).where("#{type.underscore.pluralize}": { distributed_type: determine_dt })
  end

  # rubocop:enable Metrics/AbcSize

  def group_by_product(line_items)
    line_items.group(:product_id, :product_type_id, :itemable_type).select(
      :product_id, :product_type_id, 'product_id as id, SUM(quantity) as quantity, SUM(unit_price) as unit_price'
    )
  end

  # rubocop:disable Metrics/AbcSize
  def filter_by_distributed_by(line_items)
    return line_items unless distributed_by.present? && type.eql?('Distribution')

    line_items.joins(
      "INNER JOIN #{type.underscore.pluralize} ON #{type.underscore.pluralize}.id = line_items.itemable_id AND "\
      "line_items.itemable_type='#{type}'"
    ).where("#{type.underscore.pluralize}": { from_id: groups.ids })
  end

  # rubocop:enable Metrics/AbcSize

  # rubocop:disable Metrics/MethodLength,Metrics/AbcSize
  def received_line_items(line_items)
    case type
    when 'Indent'
      line_items.joins(
        "INNER JOIN #{type.underscore.pluralize} ON #{type.underscore.pluralize}.id = line_items.itemable_id AND "\
        "line_items.itemable_type='#{type}'"
      ).where(
        "#{type.underscore.pluralize}": {
          id: groups.includes(:forwarded_indents).flat_map(&:forwarded_indents).pluck(:transactionable_id)
        }
      )
    when 'Stock'
      line_items.joins(
        "INNER JOIN #{type.underscore.pluralize} ON #{type.underscore.pluralize}.id = line_items.itemable_id AND "\
        "line_items.itemable_type='#{type}'"
      ).where(
        "#{type.underscore.pluralize}": {
          group_id: groups.ids
        }
      )
    else
      line_items.joins(
        "INNER JOIN #{type.underscore.pluralize} ON #{type.underscore.pluralize}.id = line_items.itemable_id AND "\
        "line_items.itemable_type='#{type}'"
      ).where(
        "#{type.underscore.pluralize}": {
          to_id: groups.ids
        }
      )
    end
  end

  def submitted_line_items(line_items)
    case type
    when 'Indent'
      line_items.joins(
        "INNER JOIN #{type.underscore.pluralize} ON #{type.underscore.pluralize}.id = line_items.itemable_id AND "\
        "line_items.itemable_type='#{type}'"
      ).where(
        "#{type.underscore.pluralize}": {
          id: groups.includes(:requested_indents).flat_map(&:requested_indents).pluck(:transactionable_id)
        }
      )
    when 'Stock'
      line_items.joins(
        "INNER JOIN #{type.underscore.pluralize} ON #{type.underscore.pluralize}.id = line_items.itemable_id AND "\
        "line_items.itemable_type='#{type}'"
      ).where(
        "#{type.underscore.pluralize}": {
          group_id: groups.ids
        }
      )
    else
      line_items.joins(
        "INNER JOIN #{type.underscore.pluralize} ON #{type.underscore.pluralize}.id = line_items.itemable_id AND "\
        "line_items.itemable_type='#{type}'"
      ).where(
        "#{type.underscore.pluralize}": {
          from_id: groups.ids
        }
      )
    end
  end

  # rubocop:enable Metrics/MethodLength,Metrics/AbcSize

  def determine_dt
    distributed_type.presence_in(DISTRIBUTED_TYPE) || 'self'
  end

  # rubocop:disable Metrics/MethodLength,Metrics/CyclomaticComplexity,Metrics/AbcSize
  def groups
    @groups ||=
      case current_role.name
      when 'ADRC'
        Group.where(role_id: current_role.id, region_id: current_group.region_id)
      when 'MHV'
        Group.where(role_id: current_role.id, company_id: current_group.company_id)
      when 'DAO'
        type.eql?('Surrender') ?
          Group.where(name: %w[NPPC ADRC DAO]) :
          Group.where(region_id: current_group.region_id, district_id: current_group.district_id)
      when 'EA'
        type.eql?('Surrender') ?
          Group.where(name: %w[NPPC ADRC DAO EA]) :
          Group.where(
            region_id: current_group.region_id, district_id: current_group.district_id,
            extension_id: current_group.extension_id
          )
      when 'ASSR'
        Group.where(
          region_id: current_group.region_id, district_id: current_group.district_id,
          extension_id: current_group.extension_id, individual_id: current_group.individual_id
        )
      when 'User'
        Group.where(individual_id: current_group.individual_id)
      else
        Group.all
      end
  end

  # rubocop:enable Metrics/MethodLength,Metrics/CyclomaticComplexity,Metrics/AbcSize
end
