# frozen_string_literal: true

module Enums
  module Cart
    extend ActiveSupport::Concern

    included do
      enum category: { distribution: 0, surrender: 10, mobilization: 20 }
    end
  end
end
