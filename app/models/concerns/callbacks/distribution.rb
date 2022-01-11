# frozen_string_literal: true

module Callbacks
  module Distribution
    extend ActiveSupport::Concern

    included do
      before_create :assign_defaults
    end

    def assign_defaults
      assign_attributes(
        reference_no: CodeGenerator.new.generate,
        state: :distributed
      )
    end
  end
end
