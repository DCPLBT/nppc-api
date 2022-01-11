# frozen_string_literal: true

module Enums
  module Distribution
    extend ActiveSupport::Concern

    included do
      enum state: { distributed: 0, received: 10 }
      enum distributed_type: { ea: 0, individual: 10, self: 20, mvh: 30, assr: 40 }
    end
  end
end
