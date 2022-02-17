# frozen_string_literal: true

module Validations
  module Village
    extend ActiveSupport::Concern

    included do
      validates_presence_of :name
      validates_uniqueness_of :name, case_sensitive: false
    end
  end
end
