# frozen_string_literal: true

class OverallReportPopulator < ReportPopulator
  DISTRIBUTED_BY = %w[ea mhv assr].freeze

  def run # rubocop:disable Metrics/AbcSize,Metrics/MethodLength
    validate_submitted_or_received
    @type = 'Distribution'
    line_items
      .yield_self { |line_items| filter_by_date_range(line_items) }
      .yield_self { |line_items| filter_by_product_type(line_items) }
      .yield_self { |line_items| filter_by_product(line_items) }
      .yield_self { |line_items| filter_by_distributed_by(line_items) }
      .yield_self { |line_items| filter_by_region(line_items) }
      .yield_self { |line_items| filter_by_district(line_items) }
      .yield_self { |line_items| filter_by_extension(line_items) }
      .distinct
  end

  private

  def filter_by_distributed_by(line_items)
    return line_items unless distributed_by.present? && type.eql?('Distribution')

    items(line_items)
      .where("#{type.underscore.pluralize}": { from_id: distributors&.ids })
  end

  def determine_db
    distributed_type.presence_in(DISTRIBUTED_BY) || 'ea'
  end

  def distributors
    case determine_db
    when 'ea'
      Group.where(name: 'EA')
    when 'mhv'
      Group.where(name: 'MHV')
    when 'assr'
      Group.where(name: 'ASSR')
    end
  end
end
