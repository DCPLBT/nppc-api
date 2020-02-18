module Delegates
  module Attachment
    extend ActiveSupport::Concern

    included do
      delegate(
        :filename,
        :byte_size,
        to: :file,
        allow_nil: true
      )
    end
  end
end
