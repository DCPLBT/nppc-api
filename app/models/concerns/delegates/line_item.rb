# frozen_string_literal: true

module Delegates
  module LineItem
    extend ActiveSupport::Concern

    included do
      delegate(:name, to: :product_type, prefix: true)
      delegate(:name, to: :product, prefix: true)
    end
  end
end
