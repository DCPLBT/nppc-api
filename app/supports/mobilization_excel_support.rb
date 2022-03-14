# frozen_string_literal: true

class MobilizationExcelSupport < BaseExcelSupport
  private

  def headers
    [
      'Reference No.', 'Mobilized by', 'Region', 'Dzongkhag', 'Gewog', 'Company', 'Total Product', 'Total Quantity',
      'Total Price', 'Status', 'Approved by', 'Approved Date'
    ]
  end

  def data
    @data ||= lists.map do |d|
      [
        d.reference_no, d.user_name, d.region_name, d.district_name, d.extension_name, d.company_name, d.total_product,
        d.total_quantity, d.total_price, d.state.capitalize, d.approved_by_name,
        d.approved_on&.strftime('%d/%m/%Y %I:%M %p')
      ]
    end
  end
end
