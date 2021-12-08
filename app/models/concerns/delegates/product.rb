# frozen_string_literal: true

module Delegates
  module Product
    extend ActiveSupport::Concern

    included do
      delegate(:name, to: :product_type, prefix: true)
    end
  end
end
