namespace :rspec do
  task seed: :environment do
    load File.join(Rails.root, 'spec', 'db', 'seeds', 'roles.rb')
  end
end
