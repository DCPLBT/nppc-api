# frozen_string_literal: true

class IndentExcelSupport < BaseExcelSupport
  private

  def headers
    [
      'Reference No.', 'Created Date', 'No. of Products', 'Total Quantity', 'Status', 'Received by', 'Received Date'
    ]
  end

  def data
    @data ||= lists.map do |d|
      [
        d.reference_no, d.created_at.strftime('%d/%m/%Y %I:%M %p'), d.total_product, d.total_quantity,
        d.state.capitalize, d.accepted_by_name, d.accepted_on&.strftime('%d/%m/%Y %I:%M %p')
      ]
    end
  end
end
