# frozen_string_literal: true

class ReportSerializer < ApplicationSerializer
  attributes(
    :product_type_id,
    :product_type_name,
    :product_id,
    :product_name,
    :unit_id,
    :unit_name,
    :pack_size,
    :quantity,
    :unit_price,
    :total_price
  )
end
