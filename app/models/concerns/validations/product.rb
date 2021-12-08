# frozen_string_literal: true

module Validations
  module Product
    extend ActiveSupport::Concern

    included do
      validates_presence_of :name
      validates_uniqueness_of :name, scope: :product_type_id, case_sensitive: false
    end
  end
end
