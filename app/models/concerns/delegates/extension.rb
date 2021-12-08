# frozen_string_literal: true

module Delegates
  module Extension
    extend ActiveSupport::Concern

    included do
      delegate(:name, to: :region, district: true, allow_nil: true)
    end
  end
end
