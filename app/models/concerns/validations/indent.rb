# frozen_string_literal: true

module Validations
  module Indent
    extend ActiveSupport::Concern

    included do
      validates_inclusion_of :draft, in: [true, false]
    end
  end
end
