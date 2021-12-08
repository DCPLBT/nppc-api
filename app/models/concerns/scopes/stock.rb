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
    end
  end
end
