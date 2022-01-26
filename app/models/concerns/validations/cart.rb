# frozen_string_literal: true

module Validations
  module Cart
    extend ActiveSupport::Concern

    included do
      validates_presence_of :category
      validates_inclusion_of :category, in: categories.keys
    end
  end
end
