# frozen_string_literal: true

class ReportLineItemExcelSupport < BaseExcelSupport
  private

  def headers
    ['Product Type.', 'Product', 'Quantity', 'Unit', 'Unit Price', 'Total Price']
  end

  def data
    @data ||= lists.map do |d|
      [d.product_type_name, d.product_name, d.quantity, d.unit_name, d.unit_price, d.total_price]
    end
  end
end
