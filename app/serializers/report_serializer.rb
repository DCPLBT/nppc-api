# frozen_string_literal: true

class ReportSerializer < ApplicationSerializer
  attributes(
    :product_type_id,
    :product_type_name,
    :product_id,
    :product_name,
    :quantity,
    :unit_price,
    :total_price
  )
end
