# frozen_string_literal: true

module Scopes
  module Company
    extend ActiveSupport::Concern

    included do
      scope :search, lambda { |query|
        where(
          "CONCAT_WS(' ', name) iLIKE ?", "%#{query&.squish}%"
        )
      }
    end
  end
end
