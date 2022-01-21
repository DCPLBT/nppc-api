# frozen_string_literal: true

module Scopes
  module Stock
    extend ActiveSupport::Concern

    included do
      scope :search, lambda { |query|
        joins(:product, :product_type).where(
          "CONCAT_WS(' ', products.name, product_types.name) iLIKE ?", "%#{query&.squish}%"
        )
      }
      scope :filter_by_product_type, lambda { |id|
        where(product_type_id: id).distinct
      }
      scope :filter_by_product, lambda { |id|
        where(product_id: id).distinct
      }
    end
  end
end
