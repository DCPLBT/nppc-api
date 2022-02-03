# frozen_string_literal: true

require 'sidekiq'

Sidekiq.configure_server do |config|
  config.redis = { size: 12, url: 'redis://localhost:6379/1' }
end

Sidekiq.configure_client do |config|
  config.redis = { size: 12, url: 'redis://localhost:6379/1' }
end
