# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
puts 'Seeding roles'
[
  { id: 1, name: 'Admin', description: 'Admin' },
  { id: 2, name: 'NPPC', description: 'Nation Plant Protection Center' },
  { id: 3, name: 'DAO', description: 'Dzongkhag Agriculture Officer' },
  { id: 4, name: 'EA', description: 'Extension Agent' },
  { id: 5, name: 'ADRC', description: 'Region' },
  { id: 6, name: 'MHV', description: 'Company' },
  { id: 7, name: 'ASSR', description: 'Sales Agent' },
  { id: 8, name: 'User', description: 'Individual' }
].each do |role|
  Role.create(role)
end

puts 'Seeding users'
[
  { id: 1, email: 'td@dcpl.bt', password: 'Dcpl@123', role_ids: [1], active: true },
  { id: 2, email: 'td+1@dcpl.bt', password: 'Dcpl@123', role_ids: [2], active: true },
  { id: 3, email: 'td+2@dcpl.bt', password: 'Dcpl@123', role_ids: [3], active: true },
  { id: 4, email: 'td+3@dcpl.bt', password: 'Dcpl@123', role_ids: [4], active: true },
  { id: 5, email: 'td+4@dcpl.bt', password: 'Dcpl@123', role_ids: [5], active: true },
  { id: 6, email: 'td+5@dcpl.bt', password: 'Dcpl@123', role_ids: [6], active: true },
  { id: 7, email: 'td+6@dcpl.bt', password: 'Dcpl@123', role_ids: [7], active: true },
  { id: 8, email: 'td+7@dcpl.bt', password: 'Dcpl@123', role_ids: [8], active: true }
].each do |user|
  user = User.new(user)
  next if user.persisted?

  user.skip_confirmation!
  user.save
  user.confirm
end

ActiveRecord::Base.connection.tables.each do |t|
  ActiveRecord::Base.connection.reset_pk_sequence!(t)
end
