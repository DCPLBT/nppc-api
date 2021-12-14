# frozen_string_literal: true

module Scopes
  module Indent
    extend ActiveSupport::Concern

    included do
      scope :search, lambda { |query|
        left_joins(requester: :profile, forwarded_to: :profile).where(
          "CONCAT_WS(' ', profiles.firstname, profiles.lastname) iLIKE ?", "%#{query&.squish}%"
        )
      }
    end
  end
end
