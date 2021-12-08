# frozen_string_literal: true

module Validations
  module Stock
    extend ActiveSupport::Concern

    included do
      validates_presence_of :quantity, :unit_price
    end
  end
end
