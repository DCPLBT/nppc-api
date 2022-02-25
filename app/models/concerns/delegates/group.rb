# frozen_string_literal: true

module Delegates
  module Group
    extend ActiveSupport::Concern

    included do
      delegate(:name, to: :role, prefix: true)
      delegate(:name, to: :region, prefix: true, allow_nil: true)
      delegate(:name, to: :district, prefix: true, allow_nil: true)
      delegate(:name, to: :extension, prefix: true, allow_nil: true)
      delegate(:name, to: :village, prefix: true, allow_nil: true)
      delegate(:name, to: :company, prefix: true, allow_nil: true)
    end
  end
end
