# frozen_string_literal: true

class ReportPopulator < BasePopulator # rubocop:disable Metrics/ClassLength
  DISTRIBUTED_TYPE = %w[self individual].freeze

  attr_accessor :product_type_id, :product_id, :received, :submitted, :type, :region_id, :district_id,
                :extension_id, :company_id, :distributed_type, :distributed_by, :village_id, :sale_agent_id

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
      .yield_self { |line_items| filter_by_sales_agent(line_items) }
      .distinct
      .yield_self { |line_items| group_by_product(line_items) }
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
    return line_items unless submitted.present? && determine_boolean(submitted)

    submitted_line_items(line_items)
  end

  # rubocop:disable Metrics/AbcSize
  def filter_by_distributed_type(line_items)
    return line_items unless distributed_type.present? && type.eql?('Distribution')

    items(line_items).where("#{type.underscore.pluralize}": { distributed_type: determine_dt })
  end

  def filter_by_region(line_items)
    return line_items unless region_id.present?

    if submitted.present? && determine_boolean(submitted)
      items(line_items)
        .joins("INNER JOIN groups ON groups.id = #{type.underscore.pluralize}.from_id")
        .where(groups: { region_id: region_id })
    else
      items(line_items)
        .joins("INNER JOIN groups ON groups.id = #{type.underscore.pluralize}.to_id")
        .where(groups: { region_id: region_id })
    end
  end

  def filter_by_district(line_items)
    return line_items unless district_id.present?

    if submitted.present? && determine_boolean(submitted)
      items(line_items)
        .joins("INNER JOIN groups ON groups.id = #{type.underscore.pluralize}.from_id")
        .where(groups: { district_id: district_id })
    else
      items(line_items)
        .joins("INNER JOIN groups ON groups.id = #{type.underscore.pluralize}.to_id")
        .where(groups: { district_id: district_id })
    end
  end

  def filter_by_extension(line_items)
    return line_items unless extension_id.present?

    if submitted.present? && determine_boolean(submitted)
      items(line_items)
        .joins("INNER JOIN groups ON groups.id = #{type.underscore.pluralize}.from_id")
        .where(groups: { region_id: region_id })
    else
      items(line_items)
        .joins("INNER JOIN groups ON groups.id = #{type.underscore.pluralize}.to_id")
        .where(groups: { region_id: region_id })
    end
  end

  def filter_by_village(line_items)
    return line_items unless village_id.present? && type.eql?('Distribution')

    if submitted.present? && determine_boolean(submitted)
      items(line_items).where("#{type.underscore.pluralize}": { village_id: village_id })
    else
      items(line_items)
        .joins("INNER JOIN groups ON groups.id = #{type.underscore.pluralize}.to_id")
        .where(groups: { village_id: village_id })
    end
  end

  def filter_by_company(line_items)
    return line_items unless company_id.present? && type.eql?('Distribution')

    if submitted.present? && determine_boolean(submitted)
      items(line_items)
        .joins("INNER JOIN groups ON groups.id = #{type.underscore.pluralize}.from_id")
        .where(groups: { company_id: company_id })
    else
      items(line_items)
        .joins("INNER JOIN groups ON groups.id = #{type.underscore.pluralize}.to_id")
        .where(groups: { company_id: company_id })
    end
  end

  def filter_by_sales_agent(line_items)
    return line_items unless sale_agent_id.present? && type.eql?('Distribution')

    if submitted.present? && determine_boolean(submitted)
      items(line_items)
        .joins("INNER JOIN groups ON groups.id = #{type.underscore.pluralize}.from_id")
        .where(groups: { individual_id: sale_agent_id })
    else
      items(line_items)
        .joins("INNER JOIN groups ON groups.id = #{type.underscore.pluralize}.to_id")
        .where(groups: { individual_id: sale_agent_id })
    end
  end

  # rubocop:enable Metrics/AbcSize

  def group_by_product(line_items)
    line_items
      .group(:product_id, :product_type_id, :itemable_type, :unit_id)
      .select(
        :product_id, :product_type_id, :unit_id,
        'product_id as id, SUM(quantity) as quantity, SUM(unit_price) as unit_price'
      )
  end

  def received_line_items(line_items)
    items(line_items).where("#{type.underscore.pluralize}": { to_id: groups.ids })
  end

  def submitted_line_items(line_items)
    items(line_items).where("#{type.underscore.pluralize}": { from_id: groups.ids })
  end

  def items(line_items)
    @items ||= line_items.joins(
      "INNER JOIN #{type.underscore.pluralize} ON #{type.underscore.pluralize}.id = line_items.itemable_id AND "\
      "line_items.itemable_type='#{type}'"
    )
  end

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
        Group.where(region_id: current_group.region_id, district_id: current_group.district_id)
      when 'EA'
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
