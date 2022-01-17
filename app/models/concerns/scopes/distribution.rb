# frozen_string_literal: true

module Scopes
  module Distribution
    extend ActiveSupport::Concern

    included do
      default_scope -> { order(created_at: :desc) }
      scope :search, lambda { |query|
        joins(line_items: %i[product_type product]).where(
          "CONCAT_WS(' ', reference_no, product_types.name, products.name) iLIKE ?", "%#{query&.squish}%"
        )
      }
      scope :filter_by_product_type, lambda { |id|
        joins(:line_items).where(line_items: { product_type_id: id }).distinct
      }
      scope :filter_by_product, lambda { |id|
        joins(:line_items).where(line_items: { product_id: id }).distinct
      }
      scope :filter_by_region, lambda { |id|
        where(region_id: id).distinct
      }
      scope :filter_by_district, lambda { |id|
        where(district_id: id).distinct
      }
      scope :filter_by_extension, lambda { |id|
        where(extension_id: id).distinct
      }
    end
  end
end
