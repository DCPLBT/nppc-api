# frozen_string_literal: true

# == Schema Information
#
# Table name: surrenders
#
#  id             :bigint           not null, primary key
#  received_on    :datetime
#  reference_no   :string
#  state          :integer
#  surrender_type :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  district_id    :bigint
#  extension_id   :bigint
#  from_id        :bigint
#  received_by_id :bigint
#  region_id      :bigint
#  to_id          :bigint
#  user_id        :bigint           not null
#
# Indexes
#
#  index_surrenders_on_district_id     (district_id)
#  index_surrenders_on_extension_id    (extension_id)
#  index_surrenders_on_from_id         (from_id)
#  index_surrenders_on_received_by_id  (received_by_id)
#  index_surrenders_on_region_id       (region_id)
#  index_surrenders_on_to_id           (to_id)
#  index_surrenders_on_user_id         (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (district_id => districts.id)
#  fk_rails_...  (extension_id => extensions.id)
#  fk_rails_...  (region_id => regions.id)
#  fk_rails_...  (user_id => users.id)
#
FactoryBot.define do
  factory :surrender do
    region { nil }
    district { nil }
    extension { nil }
    user { nil }
    surrender_type { 1 }
    state { 0 }
    reference_no { 'MyString' }
  end
end
