# frozen_string_literal: true

module Enums
  module Setting
    extend ActiveSupport::Concern

    included do
      enum category: { indent: 0, obsolete: 10 }
    end
  end
end
