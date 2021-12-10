# frozen_string_literal: true

module Validations
  module Indent
    extend ActiveSupport::Concern

    included do
      validates_presence_of :quantity
    end
  end
end
