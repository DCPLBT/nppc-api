# frozen_string_literal: true

puts 'Seeding villages of Tsirang...'

[
  # Barshong
  { id: '4140', name: 'Chunyikhang(Baradhurey)', user_id: User.first.id, extension_id: 184 },
  { id: '4141', name: 'Gangtokha(Daragang)', user_id: User.first.id, extension_id: 184 },
  { id: '4142', name: 'Gairigang Ka(Gairigaon A)', user_id: User.first.id, extension_id: 184 },
  { id: '4143', name: 'Gairigang Kha(Gairigaon B)', user_id: User.first.id, extension_id: 184 },
  { id: '4144', name: 'Lungkhorma(Phipherey)', user_id: User.first.id, extension_id: 184 },
  { id: '4145', name: 'Toisang', user_id: User.first.id, extension_id: 184 },

  # Doonglagang
  { id: '4155', name: 'Dangraybhu(Bichgaon)', user_id: User.first.id, extension_id: 185 },
  { id: '4156', name: 'Kherithang(Khorsaney)', user_id: User.first.id, extension_id: 185 },
  { id: '4157', name: 'Norjangsa(Lalikharka)', user_id: User.first.id, extension_id: 185 },
  { id: '4158', name: 'Lhamoi Lum /Gopini', user_id: User.first.id, extension_id: 185 },

  # Gosarling
  { id: '4160', name: 'Chokpur', user_id: User.first.id, extension_id: 186 },
  { id: '4161', name: 'Phuensumgang Ka(Gairigaon A)', user_id: User.first.id, extension_id: 186 },
  { id: '4162', name: 'Zomlingthang(Lower Lobsibotay)', user_id: User.first.id, extension_id: 186 },
  { id: '4163', name: 'Zamlingzor(Upper Suntolay)', user_id: User.first.id, extension_id: 186 },
  { id: '4164', name: 'Pelrithang(Upper Lobsibotay)', user_id: User.first.id, extension_id: 186 },
  { id: '4165', name: 'Phuensumgang Kha (Gairigaon B)', user_id: User.first.id, extension_id: 186 },
  { id: '4166', name: 'Pemathang(Lower Suntaley)', user_id: User.first.id, extension_id: 186 },

  # Kilkhorthang
  { id: '4168', name: 'Dekiling(Lower Bockray)', user_id: User.first.id, extension_id: 187 },
  { id: '4169', name: 'Tashiyangjong(Lower Salami)', user_id: User.first.id, extension_id: 187 },
  { id: '4170', name: 'Satsangma(Majuwa)', user_id: User.first.id, extension_id: 187 },
  { id: '4171', name: 'Menchana/Mithun', user_id: User.first.id, extension_id: 187 },
  { id: '4172', name: 'Dungkhar Choeling(Upper Bockray)', user_id: User.first.id, extension_id: 187 },
  { id: '4173', name: 'Nezergang(Upper Salami)', user_id: User.first.id, extension_id: 187 },

  # Mendrelgang
  { id: '4175', name: 'Mendrelgang/Lamidara', user_id: User.first.id, extension_id: 188 },
  { id: '4176', name: 'Pema Shong/Sarkigaon', user_id: User.first.id, extension_id: 188 },
  { id: '4177', name: 'Riserbo A/Kamigaon', user_id: User.first.id, extension_id: 188 },
  { id: '4178', name: 'Riserbo A/Rateykhola', user_id: User.first.id, extension_id: 188 },
  { id: '4179', name: 'Riserbo B/Kamigaon', user_id: User.first.id, extension_id: 188 },
  { id: '4180', name: 'Samshing Gaden Manidara', user_id: User.first.id, extension_id: 188 },
  { id: '4181', name: 'Tashipang/Gurungaon', user_id: User.first.id, extension_id: 188 },
  { id: '4182', name: 'Zamling Zor/Majigaon', user_id: User.first.id, extension_id: 188 },
  { id: '4183', name: 'Zamling Zor/Manikhola', user_id: User.first.id, extension_id: 188 },
  { id: '4184', name: 'Zamling Zor/Sarkigaon', user_id: User.first.id, extension_id: 188 },

  # Patshaling (Beteni)
  { id: '4147', name: 'Patshaling(Beteni)', user_id: User.first.id, extension_id: 189 },
  { id: '4148', name: 'Chhuzomsa(Bulkay)', user_id: User.first.id, extension_id: 189 },
  { id: '4149', name: 'Jakhor(Dhanisay)', user_id: User.first.id, extension_id: 189 },
  { id: '4150', name: 'Munyulsa(Kaligaon)', user_id: User.first.id, extension_id: 189 },
  { id: '4151', name: 'Tsakaling(Katlay Kalikhola)', user_id: User.first.id, extension_id: 189 },
  { id: '4152', name: 'Pangthang(Pakhay)', user_id: User.first.id, extension_id: 189 },
  { id: '4153', name: 'Thakorling(Thangray)', user_id: User.first.id, extension_id: 189 },

  # Pungtenchhu
  { id: '4191', name: 'Gentegkha(Baithakey)', user_id: User.first.id, extension_id: 190 },
  { id: '4192', name: 'Tashicholing(Burichu)', user_id: User.first.id, extension_id: 190 },
  { id: '4193', name: 'Peljorling(Dhansiri)', user_id: User.first.id, extension_id: 190 },
  { id: '4194', name: 'Dhodomchen(Dhapkhola)', user_id: User.first.id, extension_id: 190 },
  { id: '4195', name: 'Wangthangling(Jogitar)', user_id: User.first.id, extension_id: 190 },
  { id: '4196', name: 'Menchhunang(Kharkhola)', user_id: User.first.id, extension_id: 190 },
  { id: '4197', name: 'Norbuthang(Manitar)', user_id: User.first.id, extension_id: 190 },
  { id: '4198', name: 'Serzhong(Phaleday)', user_id: User.first.id, extension_id: 190 },
  { id: '4199', name: 'Dragithog(S/Melay)', user_id: User.first.id, extension_id: 190 },
  { id: '4200', name: 'Jiligang(Saprali)', user_id: User.first.id, extension_id: 190 },
  { id: '4201', name: 'Drongtod(Saureni)', user_id: User.first.id, extension_id: 190 },
  { id: '4202', name: 'Tongshinggang(T/Melay)', user_id: User.first.id, extension_id: 190 },
  { id: '4203', name: 'Chhubapsa(Tshangay)', user_id: User.first.id, extension_id: 190 },

  # Rangthangling
  { id: '4205', name: 'Chanautre', user_id: User.first.id, extension_id: 191 },
  { id: '4206', name: 'Darchargang(Dhajey)', user_id: User.first.id, extension_id: 191 },
  { id: '4207', name: 'Gagaling(Ghaga Goan)', user_id: User.first.id, extension_id: 191 },
  { id: '4208', name: 'Neymedsa(Nevarey)', user_id: User.first.id, extension_id: 191 },
  { id: '4209', name: 'Nimazor/Herabotay', user_id: User.first.id, extension_id: 191 },
  { id: '4210', name: 'Rangthangling/Chanautre', user_id: User.first.id, extension_id: 191 },
  { id: '4211', name: 'Dawthongsa(Saunay)', user_id: User.first.id, extension_id: 191 },
  { id: '4212', name: 'Sunkosh', user_id: User.first.id, extension_id: 191 },
  { id: '4213', name: 'Charingma(Zulphaygaon)', user_id: User.first.id, extension_id: 191 },

  # Semjong
  { id: '4215', name: 'Tashiling(Bararay)', user_id: User.first.id, extension_id: 192 },
  { id: '4216', name: 'Dangreygang(Daragaon)', user_id: User.first.id, extension_id: 192 },
  { id: '4217', name: 'Khiling(Katikey)', user_id: User.first.id, extension_id: 192 },
  { id: '4218', name: 'Dekiling(Kokray)', user_id: User.first.id, extension_id: 192 },

  # Sergithang (Patala)
  { id: '4186', name: 'Malbasey', user_id: User.first.id, extension_id: 193 },
  { id: '4187', name: 'Norbugang(Mazgaon)', user_id: User.first.id, extension_id: 193 },
  { id: '4188', name: 'Tashithang(Patale Tar)', user_id: User.first.id, extension_id: 193 },
  { id: '4189', name: 'Semdenjong(Teoray)', user_id: User.first.id, extension_id: 193 },

  # Tsholingkhar
  { id: '4220', name: 'Alenchi(Alaichey)', user_id: User.first.id, extension_id: 194 },
  { id: '4221', name: 'Drupchhugang(Harpaypani)', user_id: User.first.id, extension_id: 194 },
  { id: '4222', name: 'Kapasay', user_id: User.first.id, extension_id: 194 },
  { id: '4223', name: 'Tshokana Med(Lower Tshokana)', user_id: User.first.id, extension_id: 194 },
  { id: '4224', name: 'Gomsum(Tintalay)', user_id: User.first.id, extension_id: 194 },
  { id: '4225', name: 'Tshokana Tod(Upper Tshokana)', user_id: User.first.id, extension_id: 194 },

  # Tsirang Toed
  { id: '4227', name: 'Tagthang(Bhaktar)', user_id: User.first.id, extension_id: 195 },
  { id: '4228', name: 'Dungkarling(Bouri)', user_id: User.first.id, extension_id: 195 },
  { id: '4229', name: 'Sontabsa(Dalleni)', user_id: User.first.id, extension_id: 195 },
  { id: '4230', name: 'Wangphu(Dauthrey)', user_id: User.first.id, extension_id: 195 },
  { id: '4231', name: 'Zomna(Jingay)', user_id: User.first.id, extension_id: 195 },
  { id: '4232', name: 'Kapasay', user_id: User.first.id, extension_id: 195 },
  { id: '4233', name: 'Tongshingnang(Salleri)', user_id: User.first.id, extension_id: 195 },
  { id: '4234', name: 'Chhuboelsa(Simpani)', user_id: User.first.id, extension_id: 195 },
  { id: '4235', name: 'Tsirangtoe', user_id: User.first.id, extension_id: 195 },
  { id: '4236', name: 'Damtshang', user_id: User.first.id, extension_id: 195 },

  # Tsirang Thromde
  { id: '4237', name: 'Tsirang Throm', user_id: User.first.id, extension_id: 196 }
].each do |v|
  Village.find_or_create_by!(v)
end
