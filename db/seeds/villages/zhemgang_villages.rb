# frozen_string_literal: true

puts 'Seeding villages of Zhemgang...'

[
  # Bardo
  { id: '4609', name: 'Bardo', user_id: User.first.id, extension_id: 213 },
  { id: '4610', name: 'Digala', user_id: User.first.id, extension_id: 213 },
  { id: '4611', name: 'Khomshar', user_id: User.first.id, extension_id: 213 },
  { id: '4612', name: 'Langdurbi', user_id: User.first.id, extension_id: 213 },
  { id: '4613', name: 'Phulabi', user_id: User.first.id, extension_id: 213 },

  # Bjoka
  { id: '4615', name: 'Barpong', user_id: User.first.id, extension_id: 214 },
  { id: '4616', name: 'Chabdembha', user_id: User.first.id, extension_id: 214 },
  { id: '4617', name: 'Dali', user_id: User.first.id, extension_id: 214 },
  { id: '4618', name: 'Kamati', user_id: User.first.id, extension_id: 214 },
  { id: '4619', name: 'Trong', user_id: User.first.id, extension_id: 214 },

  # Goshing
  { id: '4621', name: 'Budhashi', user_id: User.first.id, extension_id: 215 },
  { id: '4622', name: 'Lamtang', user_id: User.first.id, extension_id: 215 },
  { id: '4623', name: 'Lechibe', user_id: User.first.id, extension_id: 215 },
  { id: '4624', name: 'Lingmapong', user_id: User.first.id, extension_id: 215 },
  { id: '4625', name: 'Mewangang', user_id: User.first.id, extension_id: 215 },
  { id: '4626', name: 'Samcholing', user_id: User.first.id, extension_id: 215 },

  # Nangkor
  { id: '4628', name: 'Buli', user_id: User.first.id, extension_id: 216 },
  { id: '4629', name: 'Buli Goenpa', user_id: User.first.id, extension_id: 216 },
  { id: '4630', name: 'Dakphel', user_id: User.first.id, extension_id: 216 },
  { id: '4631', name: 'Duenmang', user_id: User.first.id, extension_id: 216 },
  { id: '4632', name: 'Goling', user_id: User.first.id, extension_id: 216 },
  { id: '4633', name: 'Jimjong', user_id: User.first.id, extension_id: 216 },
  { id: '4634', name: 'Kamjong', user_id: User.first.id, extension_id: 216 },
  { id: '4635', name: 'Kikhar', user_id: User.first.id, extension_id: 216 },
  { id: '4636', name: 'Nyakhar', user_id: User.first.id, extension_id: 216 },
  { id: '4637', name: 'Tali', user_id: User.first.id, extension_id: 216 },
  { id: '4638', name: 'Tsheldang', user_id: User.first.id, extension_id: 216 },
  { id: '4639', name: 'Zhobling', user_id: User.first.id, extension_id: 216 },

  # Ngangla
  { id: '4641', name: 'Jangkhar', user_id: User.first.id, extension_id: 217 },
  { id: '4642', name: 'Kaktong', user_id: User.first.id, extension_id: 217 },
  { id: '4643', name: 'Marangdue', user_id: User.first.id, extension_id: 217 },
  { id: '4644', name: 'Ngangla Tong', user_id: User.first.id, extension_id: 217 },
  { id: '4645', name: 'Panbang', user_id: User.first.id, extension_id: 217 },
  { id: '4646', name: 'Pongchaling', user_id: User.first.id, extension_id: 217 },
  { id: '4647', name: 'Rebati', user_id: User.first.id, extension_id: 217 },
  { id: '4648', name: 'Sonamthang', user_id: User.first.id, extension_id: 217 },
  { id: '4649', name: 'Thinley Gang', user_id: User.first.id, extension_id: 217 },
  { id: '4650', name: 'Yumdang', user_id: User.first.id, extension_id: 217 },

  # Phangkhar
  { id: '4652', name: 'Changarzam', user_id: User.first.id, extension_id: 218 },
  { id: '4653', name: 'Chapgoen', user_id: User.first.id, extension_id: 218 },
  { id: '4654', name: 'Edhi', user_id: User.first.id, extension_id: 218 },
  { id: '4655', name: 'Mamung Trong', user_id: User.first.id, extension_id: 218 },
  { id: '4656', name: 'Panabi', user_id: User.first.id, extension_id: 218 },
  { id: '4657', name: 'Pantang', user_id: User.first.id, extension_id: 218 },
  { id: '4658', name: 'Pongchola', user_id: User.first.id, extension_id: 218 },
  { id: '4659', name: 'Salapong', user_id: User.first.id, extension_id: 218 },
  { id: '4660', name: 'Shilingtoe', user_id: User.first.id, extension_id: 218 },
  { id: '4661', name: 'Tashibi', user_id: User.first.id, extension_id: 218 },
  { id: '4662', name: 'Tradijong', user_id: User.first.id, extension_id: 218 },
  { id: '4663', name: 'Tshodrang', user_id: User.first.id, extension_id: 218 },
  { id: '4664', name: 'Zangbi', user_id: User.first.id, extension_id: 218 },

  # Shingkhar
  { id: '4666', name: 'Nimshong', user_id: User.first.id, extension_id: 219 },
  { id: '4667', name: 'Radhi', user_id: User.first.id, extension_id: 219 },
  { id: '4668', name: 'Shingkhar', user_id: User.first.id, extension_id: 219 },
  { id: '4669', name: 'Thajong', user_id: User.first.id, extension_id: 219 },
  { id: '4670', name: 'Thrisa', user_id: User.first.id, extension_id: 219 },
  { id: '4671', name: 'Wamling', user_id: User.first.id, extension_id: 219 },
  { id: '4672', name: 'Zangling', user_id: User.first.id, extension_id: 219 },

  # Trong
  { id: '4674', name: 'Berti', user_id: User.first.id, extension_id: 220 },
  { id: '4675', name: 'Dangkhar', user_id: User.first.id, extension_id: 220 },
  { id: '4676', name: 'Gomphu', user_id: User.first.id, extension_id: 220 },
  { id: '4677', name: 'Subdrang', user_id: User.first.id, extension_id: 220 },
  { id: '4678', name: 'Tama', user_id: User.first.id, extension_id: 220 },
  { id: '4679', name: 'Trong', user_id: User.first.id, extension_id: 220 },
  { id: '4680', name: 'Tshanglajong', user_id: User.first.id, extension_id: 220 },
  { id: '4681', name: 'Zurphel', user_id: User.first.id, extension_id: 220 },

  # Zhemgang Thromde
  { id: '4682', name: 'Zhemgang Throm', user_id: User.first.id, extension_id: 221 }
].each do |v|
  Village.find_or_create_by!(v)
end
