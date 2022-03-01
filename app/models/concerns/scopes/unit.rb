# frozen_string_literal: true

module Scopes
  module Unit
    extend ActiveSupport::Concern

    included do
      default_scope -> { order(:id) }
      scope :search, lambda { |query|
        where(
          "CONCAT_WS(' ', name, description) iLIKE ?", "%#{query&.squish}%"
        )
      }
    end
  end
end
