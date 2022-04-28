# frozen_string_literal: true

puts 'Seeding region...'
[
  { id: 1, user_id: User.first.id, name: 'Eastern Region: ARDC Wengkhar, Monger' },
  { id: 2, user_id: User.first.id, name: 'West Central: ARDC Bajo, Wangduephodrang' },
  { id: 3, user_id: User.first.id, name: 'Western Region (NPPC)' },
  { id: 4, user_id: User.first.id, name: 'Southern region: ARDC Samtenling, Sarpang' }
].each do |rg|
  r = Region.find_or_initialize_by(id: rg[:id])
  r.update!(rg)
end

load 'db/seeds/district.rb'
