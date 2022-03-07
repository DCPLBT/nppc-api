# frozen_string_literal: true

module Validations
  module Indent
    extend ActiveSupport::Concern

    included do
      validates_inclusion_of :draft, in: [true, false]
      validates_presence_of :region_id, :district_id, if: ->(x) { x.dao? }
      validates_presence_of :region_id, :district_id, :extension_id, if: ->(x) { x.ea? }
    end
  end
end
