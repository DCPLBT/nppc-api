# frozen_string_literal: true

abort('Rails environment is not in test mode') unless Rails.env.test?

Role.destroy_all
[
  { id: 1, name: 'Admin', description: 'Admin' },
  { id: 2, name: 'NPPC', description: 'Nation Plant Protection Center' },
  { id: 3, name: 'DAO', description: 'Dzongkhag Agriculture Officer' },
  { id: 4, name: 'EA', description: 'Extension Agent' },
  { id: 5, name: 'ADRC', description: 'Region' },
  { id: 6, name: 'MHV', description: 'Company' },
  { id: 7, name: 'ASSR', description: 'Sales Agent' },
  { id: 8, name: 'User', description: 'Individual' }
].each do |policy|
  Role.create!(policy)
end
