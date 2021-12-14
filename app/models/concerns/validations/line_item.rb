# frozen_string_literal: true

module Validations
  module LineItem
    extend ActiveSupport::Concern

    included do
      validates_presence_of :quantity
      validates_numericality_of :quantity, greater_than: 0
    end
  end
end
