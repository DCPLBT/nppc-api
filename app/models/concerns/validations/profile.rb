# frozen_string_literal: true

module Validations
  module Profile
    extend ActiveSupport::Concern

    included do
      validates_presence_of :name
      validates_presence_of :region_id, if: ->(x) { x.user.adrc? }
      validates_presence_of :region_id, :district_id, if: ->(x) { x.user.dao? }
      validates_presence_of :region_id, :district_id, :extension_id, if: ->(x) { x.user.ea? }
      validates_presence_of :company_id, if: ->(x) { x.user.mhv? }
      # validates_presence_of :region_id, :district_id, :extension_id, :village_id, if: ->(x) { x.user.user? }
    end
  end
end
