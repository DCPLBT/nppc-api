# frozen_string_literal: true

module Booleans
  module LineItem
    extend ActiveSupport::Concern

    def indent_item?
      itemable.is_a?(Indent)
    end
  end
end
