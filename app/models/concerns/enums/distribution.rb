# frozen_string_literal: true

module Enums
  module Distribution
    extend ActiveSupport::Concern

    included do
      enum state: { distributed: 0, received: 10 }
      enum distributed_type: { ea: 0, individual: 10, self: 20, mhv: 30, assr: 40, adrc: 50 }
    end
  end
end
