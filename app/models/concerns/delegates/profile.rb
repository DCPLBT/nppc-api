# frozen_string_literal: true

module Delegates
  module Profile
    extend ActiveSupport::Concern

    included do
      delegate(:name, to: :region, prefix: true)
      delegate(:name, to: :district, prefix: true)
      delegate(:name, to: :extension, prefix: true)
    end
  end
end
