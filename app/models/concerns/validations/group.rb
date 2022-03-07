# frozen_string_literal: true

module Validations
  module Group
    extend ActiveSupport::Concern

    included do
      validates_presence_of :region_id, if: ->(x) { x.role_name.eql?('ADRC') }
      validates_presence_of :region_id, :district_id, if: ->(x) { x.role_name.eql?('DAO') }
      validates_presence_of :region_id, :district_id, :extension_id, if: ->(x) { x.role_name.eql?('EA') }
      validates_presence_of :company_id, if: ->(x) { x.role_name.eql?('MHV') }
      # validates_presence_of :region_id, :district_id, :extension_id, :village_id, if: lambda { |x|
      #   x.role_name.eql?('User')
      # }
    end
  end
end
