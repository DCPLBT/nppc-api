# frozen_string_literal: true

abort('Rails environment is not in test mode') unless Rails.env.test?

Role.destroy_all
[
  {
    id: 1,
    name: 'Admin'
  },
  {
    id: 2,
    name: 'User'
  },
  {
    id: 3,
    name: 'Customer'
  }
].each do |policy|
  Role.create!(policy)
end
