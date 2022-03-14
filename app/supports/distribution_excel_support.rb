# frozen_string_literal: true

class DistributionExcelSupport < BaseExcelSupport
  private

  def headers
    [
      'Reference No.', 'Distributed to', 'Region', 'Dzongkhag', 'Gewog', 'Company', 'Total Product',
      'Total Quantity', 'Total Price', 'Status', 'Distributed By', 'Distributed On'
    ]
  end

  def data
    @data ||= lists.map do |d|
      [
        d.reference_no, d.distributed_to_name, d.region_name, d.district_name, d.extension_name,
        d.company_name, d.total_product, d.total_quantity, d.total_price, d.state.capitalize, d.user_name,
        d.created_at.strftime('%d/%m/%Y')
      ]
    end
  end
end
