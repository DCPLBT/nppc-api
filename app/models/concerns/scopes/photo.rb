# frozen_string_literal: true

module Scopes
  module Photo
    extend ActiveSupport::Concern

    included do
      default_scope -> { includes(image_attachment: :blob) }
    end
  end
end
