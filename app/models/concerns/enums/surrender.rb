# frozen_string_literal: true

module Enums
  module Surrender
    extend ActiveSupport::Concern

    included do
      enum state: { surrendered: 0, received: 10 }
      enum surrender_type: { adrc: 0, nppc: 10 }
    end
  end
end
