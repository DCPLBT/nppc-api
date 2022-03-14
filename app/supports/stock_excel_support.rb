# frozen_string_literal: true

class StockExcelSupport < BaseExcelSupport
  private

  def headers
    [
      'Product Type', 'Product', 'Procured Year', 'Expiry Date', 'Obsolete Date', 'Unit',
      'Quantity', 'Price/uint', 'Total Price', 'Added By', 'Created on'
    ]
  end

  def data # rubocop:disable Metrics/AbcSize
    @data ||= lists.map do |d|
      [
        d.product_type_name, d.product_name, d.procured_on&.strftime('%d/%m/%Y %I:%M %p'),
        d.expiry_date&.strftime('%d/%m/%Y %I:%M %p'), d.obsolete_date&.strftime('%d/%m/%Y %I:%M %p'),
        d.unit_name, d.quantity, d.unit_price, d.total_price, d.user_name, d.created_at&.strftime('%d/%m/%Y %I:%M %p')
      ]
    end
  end
end
