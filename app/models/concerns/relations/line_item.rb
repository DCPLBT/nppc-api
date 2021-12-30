# frozen_string_literal: true

module Relations
  module LineItem
    extend ActiveSupport::Concern

    included do
      belongs_to :product_type
      belongs_to :product
      belongs_to :itemable, polymorphic: true
      belongs_to :stock, optional: true
    end
  end
end
