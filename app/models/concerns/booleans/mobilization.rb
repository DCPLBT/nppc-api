# frozen_string_literal: true

module Booleans
  module Mobilization
    extend ActiveSupport::Concern

    def valid_state?
      approved? || mobilized?
    end
  end
end
