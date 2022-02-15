# frozen_string_literal: true

class ReportPopulator < BasePopulator
  REPORT = Struct.new(:id, :ea, :individual, :self, :mhv, :assr, :adrc, keyword_init: true)

  attr_accessor :product_type_id, :product_id, :received, :submitted, :type

  def run
    line_items
      .yield_self { |line_items| filter_by_date_range(line_items) }
      .yield_self { |line_items| filter_by_product_type(line_items) }
      .yield_self { |line_items| filter_by_product(line_items) }
      .yield_self { |line_items| filter_by_received(line_items) }
      .yield_self { |line_items| filter_by_submitted(line_items) }
      .distinct
      .yield_self { |line_items| group_by_product(line_items) }
  end

  def overall
    generate_reports
  end

  private

  def line_items
    @line_items ||= LineItem.where(itemable_type: type)
  end

  # Overall report for distribution section.
  def distributions
    @distributions ||= Distribution
                       .yield_self { |distributions| filter_by_date_range(distributions) }
                       .yield_self { |distributions| filter_by_product_type(distributions) }
                       .yield_self { |distributions| filter_by_product(distributions) }
  end

  def generate_reports # rubocop:disable Metrics/AbcSize
    [REPORT.new(
      id: rand,
      ea: distributions.ea.flat_map(&:line_items).size,
      individual: distributions.individual.flat_map(&:line_items).size,
      self: distributions.self.flat_map(&:line_items).size,
      mhv: distributions.mhv.flat_map(&:line_items).size,
      assr: distributions.assr.flat_map(&:line_items).size,
      adrc: distributions.adrc.flat_map(&:line_items).size
    )]
  end

  # Filters list
  def filter_by_product_type(lists)
    return lists unless product_type_id.present?

    lists.filter_by_product_type(product_type_id)
  end

  def filter_by_product(lists)
    return lists unless product_id.present?

    lists.filter_by_product(product_id)
  end

  def filter_by_received(lists) # rubocop:disable Metrics/AbcSize
    return lists unless received.present? || determine_boolean(received)

    lists.joins(
      "INNER JOIN #{type.underscore.pluralize} ON #{type.underscore.pluralize}.id = line_items.itemable_id AND "\
      "line_items.itemable_type='#{type}'"
    ).where("#{type.underscore.pluralize}": { id: received_ids }).distinct
  end

  def filter_by_submitted(lists) # rubocop:disable Metrics/AbcSize
    return lists unless submitted.present? || determine_boolean(submitted)

    lists.joins(
      "INNER JOIN #{type.underscore.pluralize} ON #{type.underscore.pluralize}.id = line_items.itemable_id AND "\
      "line_items.itemable_type='#{type}'"
    ).where("#{type.underscore.pluralize}": { id: submitted_ids }).distinct
  end

  def group_by_product(lists)
    lists.group(:product_id, :product_type_id, :itemable_type).select(
      :product_id, :product_type_id, 'product_id as id, SUM(quantity) as quantity, SUM(unit_price) as unit_price'
    )
  end

  def received_ids # rubocop:disable Metrics/MethodLength
    case type
    when 'Indent'
      current_user.forwarded_indents.ids
    when 'Distribution'
      current_user.distributed_tos_distributions.ids
    when 'Stock'
      current_user.user_stocks.ids
    when 'Surrender'
      current_user.surrendered_to_products.ids
    when 'Mobilization'
      current_user.mobilized_tos_mobilizations.ids
    else
      []
    end
  end

  def submitted_ids # rubocop:disable Metrics/MethodLength
    case type
    when 'Indent'
      current_user.requested_indents.ids
    when 'Distribution'
      current_user.distributors_distributions.ids
    when 'Stock'
      current_user.user_stocks.ids
    when 'Surrender'
      current_user.surrenderer_products.ids
    when 'Mobilization'
      current_user.mobilizers_mobilizations.ids
    else
      []
    end
  end
end
