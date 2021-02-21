# frozen_string_literal: true

module Delegates
  module Photo
    extend ActiveSupport::Concern

    included do
      delegate(
        :filename,
        :byte_size,
        to: :image,
        allow_nil: true
      )
    end
  end
end
