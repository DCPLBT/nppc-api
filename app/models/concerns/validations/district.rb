# frozen_string_literal: true

module Validations
  module District
    extend ActiveSupport::Concern

    included do
      validates_presence_of :name
      validates_uniqueness_of :name, scope: :region_id
    end
  end
end
