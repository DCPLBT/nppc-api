# frozen_string_literal: true

namespace :db do
  task region: :environment do
    load File.join(Rails.root, 'db', 'seeds', 'region.rb')
  end
end
