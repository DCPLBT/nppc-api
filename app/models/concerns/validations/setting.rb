# frozen_string_literal: true

module Validations
  module Setting
    extend ActiveSupport::Concern

    included do
      validates_presence_of :category
    end
  end
end
