# frozen_string_literal: true

module Validations
  module Surrender
    extend ActiveSupport::Concern

    included do
      validates_presence_of :surrender_type
      validates_presence_of :line_items, message: :line_item_required
    end
  end
end
