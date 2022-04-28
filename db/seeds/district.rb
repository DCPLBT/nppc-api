# frozen_string_literal: true

puts 'Seeding dzongkhag...'
[
  { id: 1, user_id: User.first.id, region_id: 1, name: 'Bumthang' },
  { id: 2, user_id: User.first.id, region_id: 3, name: 'Chhukha' },
  { id: 3, user_id: User.first.id, region_id: 2, name: 'Dagana' },
  { id: 4, user_id: User.first.id, region_id: 2, name: 'Gasa' },
  { id: 5, user_id: User.first.id, region_id: 3, name: 'Haa' },
  { id: 6, user_id: User.first.id, region_id: 1, name: 'Lhuentse' },
  { id: 7, user_id: User.first.id, region_id: 1, name: 'Mongar' },
  { id: 8, user_id: User.first.id, region_id: 3, name: 'Paro' },
  { id: 9, user_id: User.first.id, region_id: 1, name: 'Pema Gatshel' },
  { id: 10, user_id: User.first.id, region_id: 2, name: 'Punakha' },
  { id: 11, user_id: User.first.id, region_id: 4, name: 'Samdrup Jongkhar' },
  { id: 12, user_id: User.first.id, region_id: 4, name: 'Samtse' },
  { id: 13, user_id: User.first.id, region_id: 4, name: 'Sarpang' },
  { id: 14, user_id: User.first.id, region_id: 3, name: 'Thimphu' },
  { id: 15, user_id: User.first.id, region_id: 1, name: 'Trashigang' },
  { id: 16, user_id: User.first.id, region_id: 1, name: 'Trashi Yangtse' },
  { id: 17, user_id: User.first.id, region_id: 4, name: 'Trongsa' },
  { id: 18, user_id: User.first.id, region_id: 2, name: 'Tsirang' },
  { id: 19, user_id: User.first.id, region_id: 2, name: 'Wangdue Phodrang' },
  { id: 20, user_id: User.first.id, region_id: 4, name: 'Zhemgang' }
].each do |dz|
  d = District.find_or_initialize_by(id: dz[:id])
  d.update!(dz)
end

load 'db/seeds/extension.rb'
