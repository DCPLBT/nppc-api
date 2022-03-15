# frozen_string_literal: true

module Scopes
  module LineItem
    extend ActiveSupport::Concern

    included do
      scope :search, lambda { |query|
        joins(:product, :product_type).where(
          "CONCAT_WS(' ', products.name, product_types.name) iLIKE ?", "%#{query&.squish}%"
        )
      }
      scope :filter_by_product_type, lambda { |product_type_id|
        where(product_type_id: product_type_id)
      }
      scope :filter_by_product, lambda { |product_id|
        where(product_id: product_id)
      }
    end
  end
end
