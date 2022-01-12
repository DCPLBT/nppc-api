# frozen_string_literal: true

module Helpers
  module Distribution
    extend ActiveSupport::Concern

    def distributor
      @distributor ||= distributors.last
    end

    def distributed_to
      @distributed_to ||= distributed_tos.last
    end
  end
end
