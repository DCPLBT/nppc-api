# frozen_string_literal: true

module Validations
  module Distribution
    extend ActiveSupport::Concern

    included do
      validates_presence_of :distributed_type
      validates_presence_of :line_items, message: :line_item_required
    end
  end
end
