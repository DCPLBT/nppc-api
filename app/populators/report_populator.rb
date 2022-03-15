# frozen_string_literal: true

class ReportPopulator < BasePopulator # rubocop:disable Metrics/ClassLength
  DISTRIBUTED_TYPE = %w[self individual].freeze
  DISTRIBUTED_BY = %w[ea mhv assr].freeze

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
    @line_items ||= LineItem.where(itemable_type: type)
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

  # rubocop:disable Metrics/AbcSize
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

  def filter_by_village(line_items)
    return line_items unless village.present? && type.eql?('Distribution')

    line_items.joins(
      "INNER JOIN #{type.underscore.pluralize} ON #{type.underscore.pluralize}.id = line_items.itemable_id AND "\
      "line_items.itemable_type='#{type}'"
    ).where("#{type.underscore.pluralize}": { consumer_village: village })
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

  def group_by_product(line_items)
    line_items.group(:product_id, :product_type_id, :itemable_type).select(
      :product_id, :product_type_id, 'product_id as id, SUM(quantity) as quantity, SUM(unit_price) as unit_price'
    )
  end

  def filter_by_distributed_by(line_items)
    return line_items unless distributed_by.present? && type.eql?('Distribution')

    line_items.joins(
      "INNER JOIN #{type.underscore.pluralize} ON #{type.underscore.pluralize}.id = line_items.itemable_id AND "\
      "line_items.itemable_type='#{type}'"
    ).where("#{type.underscore.pluralize}": { id: distributed_by_ids })
  end

  def received_line_items(line_items) # rubocop:disable Metrics/MethodLength, Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity
    case type
    when 'Indent'
      return line_items if current_user.nppc?

      user = current_user.forwarded_indents.first&.user
      line_items.joins(
        "INNER JOIN #{type.underscore.pluralize} ON #{type.underscore.pluralize}.id = line_items.itemable_id AND "\
        "line_items.itemable_type='#{type}'"
      ).where(
        "#{type.underscore.pluralize}": extract_ids(user)
      )
    when 'Distribution'
      return line_items if current_user.nppc?

      user = current_user.distributed_tos_distributions.first&.user
      line_items.joins(
        "INNER JOIN #{type.underscore.pluralize} ON #{type.underscore.pluralize}.id = line_items.itemable_id AND "\
        "line_items.itemable_type='#{type}'"
      ).where(
        "#{type.underscore.pluralize}": extract_ids(user)
      )
    when 'Stock'
      current_user.user_stocks.first
      line_items
    when 'Surrender'
      return line_items if current_user.nppc?

      user = current_user.surrendered_to_products.first&.user
      line_items.joins(
        "INNER JOIN #{type.underscore.pluralize} ON #{type.underscore.pluralize}.id = line_items.itemable_id AND "\
        "line_items.itemable_type='#{type}'"
      ).where(
        "#{type.underscore.pluralize}": extract_ids(user)
      )
    when 'Mobilization'
      return line_items if current_user.nppc?

      user = current_user.mobilized_tos_mobilizations.first&.user
      line_items.joins(
        "INNER JOIN #{type.underscore.pluralize} ON #{type.underscore.pluralize}.id = line_items.itemable_id AND "\
        "line_items.itemable_type='#{type}'"
      ).where(
        "#{type.underscore.pluralize}": extract_ids(user)
      )
    else
      []
    end
  end

  # rubocop:disable Metrics/CyclomaticComplexity, Metrics/MethodLength, Metrics/PerceivedComplexity
  def submitted_line_items(line_items)
    case type
    when 'Indent'
      return line_items if current_user.nppc?

      user = current_user.requested_indents.first&.user
      line_items.joins(
        "INNER JOIN #{type.underscore.pluralize} ON #{type.underscore.pluralize}.id = line_items.itemable_id AND "\
        "line_items.itemable_type='#{type}'"
      ).where(
        "#{type.underscore.pluralize}": extract_ids(user)
      )
    when 'Distribution'
      return line_items if current_user.nppc?

      user = current_user.distributors_distributions.first&.user
      line_items.joins(
        "INNER JOIN #{type.underscore.pluralize} ON #{type.underscore.pluralize}.id = line_items.itemable_id AND "\
        "line_items.itemable_type='#{type}'"
      ).where(
        "#{type.underscore.pluralize}": extract_ids(user)
      )
    when 'Stock'
      current_user.user_stocks.ids
      line_items
    when 'Surrender'
      return line_items if current_user.nppc?

      user = current_user.surrenderer_products.first&.user
      line_items.joins(
        "INNER JOIN #{type.underscore.pluralize} ON #{type.underscore.pluralize}.id = line_items.itemable_id AND "\
        "line_items.itemable_type='#{type}'"
      ).where(
        "#{type.underscore.pluralize}": extract_ids(user)
      )
    when 'Mobilization'
      return line_items if current_user.nppc?

      user = current_user.mobilizers_mobilizations.first&.user
      line_items.joins(
        "INNER JOIN #{type.underscore.pluralize} ON #{type.underscore.pluralize}.id = line_items.itemable_id AND "\
        "line_items.itemable_type='#{type}'"
      ).where(
        "#{type.underscore.pluralize}": extract_ids(user)
      )
    else
      []
    end
  end
  # rubocop:enable Metrics/CyclomaticComplexity, Metrics/MethodLength, Metrics/PerceivedComplexity

  def distributed_by_ids
    @user = case determine_db
            when 'ea'
              User.includes(:roles).similar_users(determine_db, region_id, district_id, extension_id, nil).first
            when 'mhv'
              User.includes(:roles).similar_users(determine_db, nil, nil, nil, company_id).first
            when 'assr'
              User.find_by(sale_agent_id)
            end
    @user&.distributors_distributions&.ids
  end

  # rubocop:enable Metrics/AbcSize

  def determine_dt
    distributed_type.presence_in(DISTRIBUTED_TYPE) || 'self'
  end

  def determine_db
    distributed_type.presence_in(DISTRIBUTED_BY) || 'ea'
  end

  def extract_ids(user) # rubocop:disable Metrics/MethodLength
    case current_role_name
    when 'adrc'
      { region_id: user&.region_id }
    when 'dao'
      { region_id: user&.region_id, district_id: user&.district_id }
    when 'ea'
      { region_id: user&.region_id, district_id: user&.district_id, extension_id: user&.extension_id }
    when 'mhv'
      { company_id: user&.company_id }
    else
      {}
    end
  end
end
