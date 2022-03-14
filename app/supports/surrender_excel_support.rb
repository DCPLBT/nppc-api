# frozen_string_literal: true

class SurrenderExcelSupport < BaseExcelSupport
  private

  def headers
    [
      'Reference No.', 'Surrendered To', 'Total Products', 'Total Quantity', 'Total Price',
      'Status', 'Surrender By', 'Surrender On'
    ]
  end

  def data
    @data ||= lists.map do |d|
      [
        d.reference_no, d.surrendered_to_name, d.total_product,
        d.total_quantity, d.total_price, d.state.capitalize, d.user_name, d.created_at&.strftime('%d/%m/%Y %I:%M %p')
      ]
    end
  end
end
