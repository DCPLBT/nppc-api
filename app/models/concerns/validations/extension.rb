# frozen_string_literal: true

module Validations
  module Extension
    extend ActiveSupport::Concern

    included do
      validates_presence_of :name
      validates_uniqueness_of :name, scope: :district_id
    end
  end
end
