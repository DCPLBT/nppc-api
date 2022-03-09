# frozen_string_literal: true

# == Schema Information
#
# Table name: distributions
#
#  id               :bigint           not null, primary key
#  consumer_cid     :string
#  consumer_ids     :string           is an Array
#  consumer_name    :string
#  consumer_village :string
#  distributed_type :integer
#  draft            :boolean
#  reference_no     :string
#  state            :integer
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  company_id       :bigint
#  district_id      :bigint
#  extension_id     :bigint
#  from_id          :bigint
#  region_id        :bigint
#  to_id            :bigint
#  user_id          :bigint           not null
#  village_id       :bigint
#
# Indexes
#
#  index_distributions_on_company_id    (company_id)
#  index_distributions_on_district_id   (district_id)
#  index_distributions_on_extension_id  (extension_id)
#  index_distributions_on_from_id       (from_id)
#  index_distributions_on_region_id     (region_id)
#  index_distributions_on_to_id         (to_id)
#  index_distributions_on_user_id       (user_id)
#  index_distributions_on_village_id    (village_id)
#
# Foreign Keys
#
#  fk_rails_...  (company_id => companies.id)
#  fk_rails_...  (district_id => districts.id)
#  fk_rails_...  (extension_id => extensions.id)
#  fk_rails_...  (region_id => regions.id)
#  fk_rails_...  (user_id => users.id)
#  fk_rails_...  (village_id => villages.id)
#
require 'rails_helper'

RSpec.describe Distribution, type: :model do
  context 'Validations' do
    it { should validate_presence_of :distributed_type }
  end
end
