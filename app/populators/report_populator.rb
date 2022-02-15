# frozen_string_literal: true

class ReportPopulator < BasePopulator
  Report = Struct.new(:id, :ea, :individual, :self, :mhv, :assr, :adrc, keyword_init: true)

  attr_accessor :report_type, :product_type_id, :product_id

  def run
    generate_reports
  end

  private

  def distributions
    @distributions ||= Distribution
                         .yield_self { |distributions| filter_by_date_range(distributions) }
                         .yield_self { |distributions| filter_by_product_type(distributions) }
                         .yield_self { |distributions| filter_by_product(distributions) }
  end

  def filter_by_product_type(distributions)
    return distributions unless product_type_id.present?

    distributions.filter_by_product_type(product_type_id)
  end

  def filter_by_product(distributions)
    return distributions unless product_id.present?

    distributions.filter_by_product(product_id)
  end

  def generate_reports # rubocop:disable Metrics/AbcSize
    [Report.new(
      id: rand,
      ea: distributions.ea.flat_map(&:line_items).size,
      individual: distributions.individual.flat_map(&:line_items).size,
      self: distributions.self.flat_map(&:line_items).size,
      mhv: distributions.mhv.flat_map(&:line_items).size,
      assr: distributions.assr.flat_map(&:line_items).size,
      adrc: distributions.adrc.flat_map(&:line_items).size
    )]
  end
end
