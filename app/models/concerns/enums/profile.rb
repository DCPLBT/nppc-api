# frozen_string_literal: true

module Enums
  module Profile
    extend ActiveSupport::Concern

    included do
      enum gender: { male: 0, female: 10, others: 20 }
      enum employee_type: { nppc: 0, others: 10 }, _prefix: true
      enum designation: { pd: 0, ppo: 5, dao: 10, aea: 15, mvh: 20, assr: 25 }, _prefix: true
      enum agency: { nppc: 0, ea: 5, dao: 10, mhv: 15, assr: 20, ardc: 25 }, _prefix: true
    end
  end
end
