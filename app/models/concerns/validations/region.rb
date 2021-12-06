# frozen_string_literal: true

module Validations
  module Region
    extend ActiveSupport::Concern

    included do
      validates_presence_of :name
      validates_uniqueness_of :name
    end
  end
end
