# frozen_string_literal: true

module Delegates
  module LineItem
    extend ActiveSupport::Concern

    included do
      delegate(:name, to: :product_type, prefix: true)
      delegate(:name, :pack_size, to: :product, prefix: true)
      delegate(:pack_size, to: :product)
      delegate(:name, to: :unit, prefix: true)
      delegate(:name, to: :received_by, prefix: true, allow_nil: true)
      delegate(:quantity, to: :stock, prefix: true, allow_nil: true)
    end
  end
end
