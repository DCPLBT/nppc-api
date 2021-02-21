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
  { id: 1, name: 'Admin' },
  { id: 2, name: 'Customer' },
  { id: 3, name: 'User' }
].each do |role|
  Role.create(role)
end

puts 'Seeding users'
[
  { id: 1, email: 'td@dcpl.bt', password: 'Dcpl@123', role_ids: [1], active: true },
  { id: 2, email: 'td+1@dcpl.bt', password: 'Dcpl@123', role_ids: [2], active: true },
  { id: 3, email: 'td+2@dcpl.bt', password: 'Dcpl@123', role_ids: [3], active: true }
].each do |user|
  user = User.new(user)
  user.skip_confirmation!
  user.save
  user.confirm
end

ActiveRecord::Base.connection.tables.each do |t|
  ActiveRecord::Base.connection.reset_pk_sequence!(t)
end
