module Scopes
  module Video
    extend ActiveSupport::Concern

    included do
      default_scope -> { includes(clip_attachment: :blob) }
    end
  end
end
