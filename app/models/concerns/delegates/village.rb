# frozen_string_literal: true

module Delegates
  module Village
    extend ActiveSupport::Concern

    included do
      delegate(:name, to: :extension, prefix: true)
    end
  end
end
