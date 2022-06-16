# frozen_string_literal: true

puts 'Seeding geog...'

[
  # Bumthang dzongkhag
  { id: 1, name: 'Chhoekhor', user_id: User.first.id, district_id: 1 },
  { id: 2, name: 'Chhumig', user_id: User.first.id, district_id: 1 },
  { id: 3, name: 'Tang', user_id: User.first.id, district_id: 1 },
  { id: 4, name: 'Ura', user_id: User.first.id, district_id: 1 },
  { id: 5, name: 'Bumthang Thromde', user_id: User.first.id, district_id: 1 },

  # Chukha dzongkhag
  { id: 6, name: 'Bjagchhog', user_id: User.first.id, district_id: 2 },
  { id: 7, name: 'Bongo', user_id: User.first.id, district_id: 2 },
  { id: 8, name: 'Chapchha', user_id: User.first.id, district_id: 2 },
  { id: 9, name: 'Darla', user_id: User.first.id, district_id: 2 },
  { id: 10, name: 'Doongna', user_id: User.first.id, district_id: 2 },
  { id: 11, name: 'Geling', user_id: User.first.id, district_id: 2 },
  { id: 12, name: 'Getana', user_id: User.first.id, district_id: 2 },
  { id: 13, name: 'Loggchina', user_id: User.first.id, district_id: 2 },
  { id: 14, name: 'Maedtabkha', user_id: User.first.id, district_id: 2 },
  { id: 15, name: 'Samphelling (Bhalujora)', user_id: User.first.id, district_id: 2 },
  { id: 16, name: 'Phuentsholing Gewog', user_id: User.first.id, district_id: 2 },
  { id: 222, name: 'Phuentsholing Thromde', user_id: User.first.id, district_id: 2 },

  # Dagana dzongkhag
  { id: 17, name: 'Dorona', user_id: User.first.id, district_id: 3 },
  { id: 18, name: 'Drukjeygang', user_id: User.first.id, district_id: 3 },
  { id: 19, name: 'Gesarling', user_id: User.first.id, district_id: 3 },
  { id: 20, name: 'Gozhi', user_id: User.first.id, district_id: 3 },
  { id: 21, name: 'Karna', user_id: User.first.id, district_id: 3 },
  { id: 22, name: 'Karmaling (Deorali)', user_id: User.first.id, district_id: 3 },
  { id: 23, name: 'Khebisa', user_id: User.first.id, district_id: 3 },
  { id: 24, name: 'Largyab', user_id: User.first.id, district_id: 3 },
  { id: 25, name: 'Lhamoi Dzingkha', user_id: User.first.id, district_id: 3 },
  { id: 26, name: 'Nichula', user_id: User.first.id, district_id: 3 },
  { id: 27, name: 'Tashiding', user_id: User.first.id, district_id: 3 },
  { id: 28, name: 'Tsangkha', user_id: User.first.id, district_id: 3 },
  { id: 29, name: 'Tsenda-Gang', user_id: User.first.id, district_id: 3 },
  { id: 30, name: 'Tseza', user_id: User.first.id, district_id: 3 },
  { id: 31, name: 'Daga Thromde', user_id: User.first.id, district_id: 3 },

  # Gasa dzongkhag
  { id: 32, name: 'Khamaed', user_id: User.first.id, district_id: 4 },
  { id: 33, name: 'Khatoed', user_id: User.first.id, district_id: 4 },
  { id: 34, name: 'Laya', user_id: User.first.id, district_id: 4 },
  { id: 35, name: 'Lunana', user_id: User.first.id, district_id: 4 },
  { id: 36, name: 'Gasa Thromde', user_id: User.first.id, district_id: 4 },

  # Haa dzongkhag
  { id: 37, name: 'Bji', user_id: User.first.id, district_id: 5 },
  { id: 38, name: 'Uesu', user_id: User.first.id, district_id: 5 },
  { id: 39, name: 'Gakiling', user_id: User.first.id, district_id: 5 },
  { id: 40, name: 'Kar-tshog', user_id: User.first.id, district_id: 5 },
  { id: 41, name: 'Samar', user_id: User.first.id, district_id: 5 },
  { id: 42, name: 'Sangbay', user_id: User.first.id, district_id: 5 },
  { id: 43, name: 'Haa Thromde', user_id: User.first.id, district_id: 5 },

  # Lhuentse dzongkhag
  { id: 44, name: 'Gangzur', user_id: User.first.id, district_id: 6 },
  { id: 45, name: 'Jarey', user_id: User.first.id, district_id: 6 },
  { id: 46, name: 'Khoma', user_id: User.first.id, district_id: 6 },
  { id: 47, name: 'Kurtoed', user_id: User.first.id, district_id: 6 },
  { id: 48, name: 'Maenbi', user_id: User.first.id, district_id: 6 },
  { id: 49, name: 'Maedtsho', user_id: User.first.id, district_id: 6 },
  { id: 50, name: 'Minjey', user_id: User.first.id, district_id: 6 },
  { id: 51, name: 'Tsaenkhar', user_id: User.first.id, district_id: 6 },
  { id: 52, name: 'Lhuentse Thromde', user_id: User.first.id, district_id: 6 },

  # Mongar dzongkhag
  { id: 53, name: 'Balam', user_id: User.first.id, district_id: 7 },
  { id: 54, name: 'Chhaling', user_id: User.first.id, district_id: 7 },
  { id: 55, name: 'Chagsakhar', user_id: User.first.id, district_id: 7 },
  { id: 56, name: 'Dramedtse', user_id: User.first.id, district_id: 7 },
  { id: 57, name: 'Drepoong', user_id: User.first.id, district_id: 7 },
  { id: 58, name: 'Gongdue', user_id: User.first.id, district_id: 7 },
  { id: 59, name: 'Jurmed', user_id: User.first.id, district_id: 7 },
  { id: 60, name: 'Kengkhar', user_id: User.first.id, district_id: 7 },
  { id: 61, name: 'Monggar', user_id: User.first.id, district_id: 7 },
  { id: 62, name: 'Na-Rang', user_id: User.first.id, district_id: 7 },
  { id: 63, name: 'Ngatshang', user_id: User.first.id, district_id: 7 },
  { id: 64, name: 'Saling', user_id: User.first.id, district_id: 7 },
  { id: 65, name: 'Shermuhoong', user_id: User.first.id, district_id: 7 },
  { id: 66, name: 'Silambi', user_id: User.first.id, district_id: 7 },
  { id: 67, name: 'Thang-Rong', user_id: User.first.id, district_id: 7 },
  { id: 68, name: 'Tsakaling', user_id: User.first.id, district_id: 7 },
  { id: 69, name: 'Tsamang', user_id: User.first.id, district_id: 7 },
  { id: 70, name: 'Monggar Thromde', user_id: User.first.id, district_id: 7 },

  # Paro dzongkhag
  { id: 71, name: 'Dokar', user_id: User.first.id, district_id: 8 },
  { id: 72, name: 'Dopshar-ri', user_id: User.first.id, district_id: 8 },
  { id: 73, name: 'Doteng', user_id: User.first.id, district_id: 8 },
  { id: 74, name: 'Hoongrel', user_id: User.first.id, district_id: 8 },
  { id: 75, name: 'Lamgong', user_id: User.first.id, district_id: 8 },
  { id: 76, name: 'Loong-nyi', user_id: User.first.id, district_id: 8 },
  { id: 77, name: 'Nagya', user_id: User.first.id, district_id: 8 },
  { id: 78, name: 'Sharpa', user_id: User.first.id, district_id: 8 },
  { id: 79, name: 'Tsento', user_id: User.first.id, district_id: 8 },
  { id: 80, name: 'Wangchang', user_id: User.first.id, district_id: 8 },
  { id: 81, name: 'Paro Thromde', user_id: User.first.id, district_id: 8 },

  # Pema Gatshel dzongkhag
  { id: 82, name: 'Chhoekhorling', user_id: User.first.id, district_id: 9 },
  { id: 83, name: 'Chhimoong', user_id: User.first.id, district_id: 9 },
  { id: 84, name: 'Chongshing', user_id: User.first.id, district_id: 9 },
  { id: 85, name: 'Dechhenling', user_id: User.first.id, district_id: 9 },
  { id: 86, name: 'Dungmaed', user_id: User.first.id, district_id: 9 },
  { id: 87, name: 'Khar', user_id: User.first.id, district_id: 9 },
  { id: 88, name: 'Nanong', user_id: User.first.id, district_id: 9 },
  { id: 89, name: 'Norboogang', user_id: User.first.id, district_id: 9 },
  { id: 90, name: 'Shumar', user_id: User.first.id, district_id: 9 },
  { id: 91, name: 'Yurung', user_id: User.first.id, district_id: 9 },
  { id: 92, name: 'Zobel', user_id: User.first.id, district_id: 9 },
  { id: 93, name: 'Denchi Thromde', user_id: User.first.id, district_id: 9 },

  # Punakha dzongkhag
  { id: 94, name: 'Barp', user_id: User.first.id, district_id: 10 },
  { id: 95, name: 'Chhubu', user_id: User.first.id, district_id: 10 },
  { id: 96, name: 'Dzomi', user_id: User.first.id, district_id: 10 },
  { id: 97, name: 'Goenshari', user_id: User.first.id, district_id: 10 },
  { id: 98, name: 'Guma', user_id: User.first.id, district_id: 10 },
  { id: 99, name: 'Kabisa', user_id: User.first.id, district_id: 10 },
  { id: 100, name: 'Lingmukha', user_id: User.first.id, district_id: 10 },
  { id: 101, name: 'Shelnga-Bjemi', user_id: User.first.id, district_id: 10 },
  { id: 102, name: 'Talog', user_id: User.first.id, district_id: 10 },
  { id: 103, name: 'Toedpaisa', user_id: User.first.id, district_id: 10 },
  { id: 104, name: 'Toedwang', user_id: User.first.id, district_id: 10 },
  { id: 105, name: 'Khuruthang Thromde', user_id: User.first.id, district_id: 10 },

  # Samdrup Jongkhar dzongkhag
  { id: 106, name: 'Dewathang', user_id: User.first.id, district_id: 11 },
  { id: 107, name: 'Gomdar', user_id: User.first.id, district_id: 11 },
  { id: 108, name: 'Langchenphu', user_id: User.first.id, district_id: 11 },
  { id: 109, name: 'Lauri', user_id: User.first.id, district_id: 11 },
  { id: 110, name: 'Martshala', user_id: User.first.id, district_id: 11 },
  { id: 111, name: 'Orong', user_id: User.first.id, district_id: 11 },
  { id: 112, name: 'Pemathang', user_id: User.first.id, district_id: 11 },
  { id: 113, name: 'Phuentshogthang', user_id: User.first.id, district_id: 11 },
  { id: 114, name: 'Samrang', user_id: User.first.id, district_id: 11 },
  { id: 115, name: 'Serthig', user_id: User.first.id, district_id: 11 },
  { id: 116, name: 'Wangphu', user_id: User.first.id, district_id: 11 },

  # Samtse dzongkhag
  { id: 117, name: 'Norgaygang (Bara)', user_id: User.first.id, district_id: 12 },
  { id: 118, name: 'Pemaling (Biru)', user_id: User.first.id, district_id: 12 },
  { id: 119, name: 'Sang-Ngag-Chhoeling (Chargharey)', user_id: User.first.id, district_id: 12 },
  { id: 120, name: 'Doomtoed', user_id: User.first.id, district_id: 12 },
  { id: 121, name: 'Duenchhukha', user_id: User.first.id, district_id: 12 },
  { id: 122, name: 'Dophuchen (Dorokha)', user_id: User.first.id, district_id: 12 },
  { id: 123, name: 'Namgyalchhoeling', user_id: User.first.id, district_id: 12 },
  { id: 124, name: 'Phuentshogpelri (Pugli)', user_id: User.first.id, district_id: 12 },
  { id: 125, name: 'Samtse', user_id: User.first.id, district_id: 12 },
  { id: 126, name: 'Tashichhoeling (Sipsu)', user_id: User.first.id, district_id: 12 },
  { id: 127, name: 'Tading', user_id: User.first.id, district_id: 12 },
  { id: 128, name: 'Tendruk', user_id: User.first.id, district_id: 12 },
  { id: 129, name: 'Ugyentse (Nainital)', user_id: User.first.id, district_id: 12 },
  { id: 130, name: 'Yoeseltse (Ghumauney)', user_id: User.first.id, district_id: 12 },
  { id: 131, name: 'Norboogang', user_id: User.first.id, district_id: 12 },
  { id: 132, name: 'Samtse Thromde', user_id: User.first.id, district_id: 12 },

  # Sarpang dzongkhag
  { id: 133, name: 'Chhuzanggang', user_id: User.first.id, district_id: 13 },
  { id: 134, name: 'Chhudzom (Dovan)', user_id: User.first.id, district_id: 13 },
  { id: 135, name: 'Dekiling', user_id: User.first.id, district_id: 13 },
  { id: 136, name: 'Gakiling (Hilley)', user_id: User.first.id, district_id: 13 },
  { id: 137, name: 'Gelegphu', user_id: User.first.id, district_id: 13 },
  { id: 138, name: 'Jigme Chhoeling', user_id: User.first.id, district_id: 13 },
  { id: 139, name: 'Samtenling (Bhur)', user_id: User.first.id, district_id: 13 },
  { id: 140, name: 'Senggey', user_id: User.first.id, district_id: 13 },
  { id: 141, name: 'Serzhong', user_id: User.first.id, district_id: 13 },
  { id: 142, name: 'Shompangkha', user_id: User.first.id, district_id: 13 },
  { id: 143, name: 'Tareythang (Taklai)', user_id: User.first.id, district_id: 13 },
  { id: 144, name: 'Umling', user_id: User.first.id, district_id: 13 },
  { id: 223, name: 'Gelephu Thromde', user_id: User.first.id, district_id: 13 },

  # Thimphu dzongkhag
  { id: 145, name: 'Chang', user_id: User.first.id, district_id: 14 },
  { id: 146, name: 'Lingzhi', user_id: User.first.id, district_id: 14 },
  { id: 147, name: 'Soe', user_id: User.first.id, district_id: 14 },
  { id: 148, name: 'Ge-nyen', user_id: User.first.id, district_id: 14 },
  { id: 149, name: 'Kawang', user_id: User.first.id, district_id: 14 },
  { id: 150, name: 'Maedwang', user_id: User.first.id, district_id: 14 },
  { id: 151, name: 'Naro', user_id: User.first.id, district_id: 14 },
  { id: 152, name: 'Darkarla', user_id: User.first.id, district_id: 14 },
  { id: 224, name: 'Thimphu Thromde', user_id: User.first.id, district_id: 14 },

  # Trashigang dzongkhag
  { id: 153, name: 'Bartsham', user_id: User.first.id, district_id: 15 },
  { id: 154, name: 'Bidoong', user_id: User.first.id, district_id: 15 },
  { id: 155, name: 'Kanglung', user_id: User.first.id, district_id: 15 },
  { id: 156, name: 'Kangpar', user_id: User.first.id, district_id: 15 },
  { id: 157, name: 'Khaling', user_id: User.first.id, district_id: 15 },
  { id: 158, name: 'Lumang', user_id: User.first.id, district_id: 15 },
  { id: 159, name: 'Merag', user_id: User.first.id, district_id: 15 },
  { id: 160, name: 'Phongmed', user_id: User.first.id, district_id: 15 },
  { id: 161, name: 'Radhi', user_id: User.first.id, district_id: 15 },
  { id: 162, name: 'Sagteng', user_id: User.first.id, district_id: 15 },
  { id: 163, name: 'Samkhar', user_id: User.first.id, district_id: 15 },
  { id: 164, name: 'Shongphu', user_id: User.first.id, district_id: 15 },
  { id: 165, name: 'Thrimshing', user_id: User.first.id, district_id: 15 },
  { id: 166, name: 'Udzorong', user_id: User.first.id, district_id: 15 },
  { id: 167, name: 'Yangnyer', user_id: User.first.id, district_id: 15 },
  { id: 168, name: 'Trashigang Thromde', user_id: User.first.id, district_id: 15 },

  # Trashiyangtse dzongkhag
  { id: 169, name: 'Boomdeling', user_id: User.first.id, district_id: 16 },
  { id: 170, name: 'Jamkhar', user_id: User.first.id, district_id: 16 },
  { id: 171, name: 'Khamdang', user_id: User.first.id, district_id: 16 },
  { id: 172, name: 'Ramjar', user_id: User.first.id, district_id: 16 },
  { id: 173, name: 'Toedtsho', user_id: User.first.id, district_id: 16 },
  { id: 174, name: 'Tongmijangsa', user_id: User.first.id, district_id: 16 },
  { id: 175, name: 'Yangtse', user_id: User.first.id, district_id: 16 },
  { id: 176, name: 'Yalang', user_id: User.first.id, district_id: 16 },
  { id: 177, name: 'Trashi Yangtse Thromde', user_id: User.first.id, district_id: 16 },

  # Trongsa dzongkhag
  { id: 178, name: 'Draagteng', user_id: User.first.id, district_id: 17 },
  { id: 179, name: 'Korphu', user_id: User.first.id, district_id: 17 },
  { id: 180, name: 'Langthil', user_id: User.first.id, district_id: 17 },
  { id: 181, name: 'Nubi', user_id: User.first.id, district_id: 17 },
  { id: 182, name: 'Tangsibji', user_id: User.first.id, district_id: 17 },
  { id: 183, name: 'Trongsa Thromde', user_id: User.first.id, district_id: 17 },

  # Tsirang dzongkhag
  { id: 184, name: 'Barshong', user_id: User.first.id, district_id: 18 },
  { id: 185, name: 'Doonglagang', user_id: User.first.id, district_id: 18 },
  { id: 186, name: 'Gosarling', user_id: User.first.id, district_id: 18 },
  { id: 187, name: 'Kilkhorthang', user_id: User.first.id, district_id: 18 },
  { id: 188, name: 'Mendrelgang', user_id: User.first.id, district_id: 18 },
  { id: 189, name: 'Patshaling (Beteni)', user_id: User.first.id, district_id: 18 },
  { id: 190, name: 'Pungtenchhu', user_id: User.first.id, district_id: 18 },
  { id: 191, name: 'Rangthangling', user_id: User.first.id, district_id: 18 },
  { id: 192, name: 'Semjong', user_id: User.first.id, district_id: 18 },
  { id: 193, name: 'Sergithang (Patala)', user_id: User.first.id, district_id: 18 },
  { id: 194, name: 'Tsholingkhar', user_id: User.first.id, district_id: 18 },
  { id: 195, name: 'Tsirang Toed', user_id: User.first.id, district_id: 18 },
  { id: 196, name: 'Tsirang Thromde', user_id: User.first.id, district_id: 18 },

  # Wangdue Phodrang dzongkhag
  { id: 197, name: 'Athang', user_id: User.first.id, district_id: 19 },
  { id: 198, name: 'Bjenag', user_id: User.first.id, district_id: 19 },
  { id: 199, name: 'Darkar', user_id: User.first.id, district_id: 19 },
  { id: 200, name: 'Dangchhu', user_id: User.first.id, district_id: 19 },
  { id: 201, name: 'Gangteng', user_id: User.first.id, district_id: 19 },
  { id: 202, name: 'Kazhi', user_id: User.first.id, district_id: 19 },
  { id: 203, name: 'Gase Tshogongm', user_id: User.first.id, district_id: 19 },
  { id: 204, name: 'Gase Tshowogm', user_id: User.first.id, district_id: 19 },
  { id: 205, name: 'Nyishog', user_id: User.first.id, district_id: 19 },
  { id: 206, name: 'Nahi', user_id: User.first.id, district_id: 19 },
  { id: 207, name: 'Phangyuel', user_id: User.first.id, district_id: 19 },
  { id: 208, name: 'Saephu', user_id: User.first.id, district_id: 19 },
  { id: 209, name: 'Phobji', user_id: User.first.id, district_id: 19 },
  { id: 210, name: 'Ruebisa', user_id: User.first.id, district_id: 19 },
  { id: 211, name: 'Thedtsho', user_id: User.first.id, district_id: 19 },
  { id: 212, name: 'Bajo Thromde', user_id: User.first.id, district_id: 19 },

  # Zhemgang dzongkhag
  { id: 213, name: 'Bardo', user_id: User.first.id, district_id: 20 },
  { id: 214, name: 'Bjoka', user_id: User.first.id, district_id: 20 },
  { id: 215, name: 'Goshing', user_id: User.first.id, district_id: 20 },
  { id: 216, name: 'Nangkor', user_id: User.first.id, district_id: 20 },
  { id: 217, name: 'Ngangla', user_id: User.first.id, district_id: 20 },
  { id: 218, name: 'Phangkhar', user_id: User.first.id, district_id: 20 },
  { id: 219, name: 'Shingkhar', user_id: User.first.id, district_id: 20 },
  { id: 220, name: 'Trong', user_id: User.first.id, district_id: 20 },
  { id: 221, name: 'Zhemgang Thromde', user_id: User.first.id, district_id: 20 }
].each do |g|
  e = Extension.find_or_initialize_by(id: g[:id])
  e.update!(g)
end

Dir.glob(Rails.root.join('db/seeds/villages/*.rb')) do |file|
  load file
end