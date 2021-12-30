# frozen_string_literal: true

module Enums
  module Profile
    extend ActiveSupport::Concern

    included do
      enum gender: { male: 0, female: 10, others: 20 }
    end
  end
end
