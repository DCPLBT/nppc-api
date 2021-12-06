# frozen_string_literal: true

module Scopes
  module Region
    extend ActiveSupport::Concern

    included do
      scope :search, lambda { |query|
        where(
          "CONCAT_WS(' ', name, description) iLIKE ?", "%#{query&.squish}%"
        )
      }
    end
  end
end
