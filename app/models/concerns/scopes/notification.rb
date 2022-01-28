# frozen_string_literal: true

module Scopes
  module Notification
    extend ActiveSupport::Concern

    included do
      default_scope -> { order(created_at: :desc) }
      scope :search, lambda { |query|
        where(
          "CONCAT_WS(' ', title) iLIKE ?", "%#{query&.squish}%"
        )
      }
    end
  end
end
