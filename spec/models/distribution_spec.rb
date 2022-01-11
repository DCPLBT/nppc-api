# frozen_string_literal: true

# == Schema Information
#
# Table name: distributions
#
#  id               :bigint           not null, primary key
#  consumer_ids     :string           is an Array
#  distributed_type :integer
#  draft            :boolean
#  reference_no     :string
#  state            :integer
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  district_id      :bigint
#  extension_id     :bigint
#  region_id        :bigint
#  user_id          :bigint           not null
#
# Indexes
#
#  index_distributions_on_district_id   (district_id)
#  index_distributions_on_extension_id  (extension_id)
#  index_distributions_on_region_id     (region_id)
#  index_distributions_on_user_id       (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (district_id => districts.id)
#  fk_rails_...  (extension_id => extensions.id)
#  fk_rails_...  (region_id => regions.id)
#  fk_rails_...  (user_id => users.id)
#
require 'rails_helper'

RSpec.describe Distribution, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
