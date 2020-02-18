module Delegates
  module Video
    extend ActiveSupport::Concern

    included do
      delegate(
        :filename,
        :byte_size,
        to: :clip,
        allow_nil: true
      )
    end
  end
end
