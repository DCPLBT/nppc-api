# frozen_string_literal: true

module Delegates
  module District
    extend ActiveSupport::Concern

    included do
      delegate(:name, to: :region, prefix: true, allow_nil: true)
    end
  end
end
