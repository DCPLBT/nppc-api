# frozen_string_literal: true

# == Schema Information
#
# Table name: profiles
#
#  id           :bigint           not null, primary key
#  firstname    :string
#  gender       :integer
#  lastname     :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  district_id  :bigint           not null
#  extension_id :bigint           not null
#  region_id    :bigint           not null
#  user_id      :bigint           not null
#
# Indexes
#
#  index_profiles_on_district_id   (district_id)
#  index_profiles_on_extension_id  (extension_id)
#  index_profiles_on_region_id     (region_id)
#  index_profiles_on_user_id       (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (district_id => districts.id)
#  fk_rails_...  (extension_id => extensions.id)
#  fk_rails_...  (region_id => regions.id)
#  fk_rails_...  (user_id => users.id)
#
FactoryBot.define do
  factory :profile do
    firstname { 'MyString' }
    lastname { 'MyString' }
    gender { 1 }
    region { nil }
    district { nil }
    extension { nil }
    user { nil }
  end
end
