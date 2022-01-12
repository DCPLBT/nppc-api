# frozen_string_literal: true

class ApplicationSerializer
  include JSONAPI::Serializer
  include Rails.application.routes.url_helpers

  # cache_options enabled: true, cache_length: 12.hours
end
