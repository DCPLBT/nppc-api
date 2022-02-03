# frozen_string_literal: true

class ApplicationWorker
  include Sidekiq::Worker
  include Rails.application.routes.url_helpers

  sidekiq_options(
    queue: 'nppc',
    retry_queue: 'bulk',
    retry: 2
  )
end
