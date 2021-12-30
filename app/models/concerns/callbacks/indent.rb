# frozen_string_literal: true

module Callbacks
  module Indent
    extend ActiveSupport::Concern

    included do
      before_create :assign_defaults
    end

    def assign_defaults
      assign_attributes(
        reference_no: CodeGenerator.new.generate,
        state: :requested
      )
    end
  end
end
