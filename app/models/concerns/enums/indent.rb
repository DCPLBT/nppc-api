# frozen_string_literal: true

module Enums
  module Indent
    extend ActiveSupport::Concern

    included do
      enum state: { requested: 0, accepted: 10, rejected: 20 }
      enum indent_type: { ea: 0, dao: 5, nppc: 10 }
    end
  end
end
