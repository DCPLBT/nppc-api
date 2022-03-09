# frozen_string_literal: true

module Enums
  module Mobilization
    extend ActiveSupport::Concern

    included do
      enum state: { mobilized: 0, approved: 10, rejected: 20, received: 30 }
      enum category: { ea: 0, mhv: 10, assr: 20, adrc: 30 }
      validates_presence_of :region_id, if: ->(x) { x.adrc? }
      validates_presence_of :region_id, :district_id, :extension_id, if: ->(x) { x.ea? }
      validates_presence_of :company_id, if: ->(x) { x.mhv? }
    end
  end
end
