# frozen_string_literal: true

# == Schema Information
#
# Table name: profiles
#
#  id               :bigint           not null, primary key
#  firstname        :string
#  gender           :integer
#  lastname         :string
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  agency_id        :bigint           not null
#  designation_id   :bigint           not null
#  district_id      :bigint
#  employee_id      :string
#  employee_type_id :bigint           not null
#  extension_id     :bigint
#  region_id        :bigint
#  user_id          :bigint           not null
#
# Indexes
#
#  index_profiles_on_agency_id         (agency_id)
#  index_profiles_on_designation_id    (designation_id)
#  index_profiles_on_district_id       (district_id)
#  index_profiles_on_employee_type_id  (employee_type_id)
#  index_profiles_on_extension_id      (extension_id)
#  index_profiles_on_region_id         (region_id)
#  index_profiles_on_user_id           (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (agency_id => agencies.id)
#  fk_rails_...  (designation_id => designations.id)
#  fk_rails_...  (district_id => districts.id)
#  fk_rails_...  (employee_type_id => employee_types.id)
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
