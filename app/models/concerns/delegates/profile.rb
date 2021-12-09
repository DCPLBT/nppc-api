# frozen_string_literal: true

module Delegates
  module Profile
    extend ActiveSupport::Concern

    included do
      delegate(:name, to: :region, prefix: true, allow_nil: true)
      delegate(:name, to: :district, prefix: true, allow_nil: true)
      delegate(:name, to: :extension, prefix: true, allow_nil: true)
    end
  end
end