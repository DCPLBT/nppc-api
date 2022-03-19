# frozen_string_literal: true

class LineItemExcelSupport < BaseExcelSupport
  private

  def headers
    [
      'Product Type.', 'Product', 'Quantity', 'Unit Price', 'Unit', 'Total Price', 'Received Qty', 'Received by',
      'Received on'
    ]
  end

  def data
    @data ||= lists.map do |d|
      [
        d.product_type_name, d.product_name, d.quantity, d.unit_price, d.unit_name, d.total_price,
        d.received_quantity, d.received_by_name, d.received_on&.strftime('%d/%m/%Y %I:%M %p')
      ]
    end
  end
end
