# frozen_string_literal: true

module Scopes
  module Indent
    extend ActiveSupport::Concern

    included do
      scope :search, lambda { |query|
        left_joins(requester: :profile, forwarded_to: :profile).where(
          "CONCAT_WS(' ', profiles.firstname, profiles.lastname, indents.reference_no) iLIKE ?", "%#{query&.squish}%"
        )
      }
      scope :filter_by_product_type, lambda { |id|
        joins(:line_items).where(line_items: { product_type_id: id }).distinct
      }
      scope :filter_by_product, lambda { |id|
        joins(:line_items).where(line_items: { product_id: id }).distinct
      }
      scope :filter_by_region, lambda { |id|
        joins(requester: :profile).where(profiles: { region_id: id }).distinct
      }
      scope :filter_by_district, lambda { |id|
        joins(requester: :profile).where(profiles: { district_id: id }).distinct
      }
      scope :filter_by_extension, lambda { |id|
        joins(requester: :profile).where(profiles: { extension_id: id }).distinct
      }
    end
  end
end
