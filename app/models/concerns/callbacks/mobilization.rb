# frozen_string_literal: true

module Callbacks
  module Mobilization
    extend ActiveSupport::Concern

    included do
      before_create :assign_defaults
    end

    private

    def assign_defaults
      assign_attributes(
        reference_no: CodeGenerator.new.generate,
        state: :mobilized
      )
    end
  end
end
