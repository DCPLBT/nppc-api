# frozen_string_literal: true

module Delegates
  module Indent
    extend ActiveSupport::Concern

    included do
      delegate(:name, to: :product_type, prefix: true)
      delegate(:name, to: :product, prefix: true)
      delegate(:name, to: :requester, prefix: true)
      delegate(:name, to: :forwarded_to, prefix: true, allow_nil: true)
    end
  end
end