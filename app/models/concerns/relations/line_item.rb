# frozen_string_literal: true

module Relations
  module LineItem
    extend ActiveSupport::Concern

    included do
      belongs_to :product_type
      belongs_to :product
      belongs_to :unit
      belongs_to :itemable, polymorphic: true
      belongs_to :stock, optional: true
      belongs_to :received_by, optional: true, class_name: 'User'

      has_rich_text :received_remark
    end
  end
end
