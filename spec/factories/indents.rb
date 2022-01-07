# frozen_string_literal: true

# == Schema Information
#
# Table name: indents
#
#  id           :bigint           not null, primary key
#  draft        :boolean
#  reference_no :string
#  state        :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  district_id  :bigint
#  extension_id :bigint
#  region_id    :bigint
#  stock_id     :bigint
#
# Indexes
#
#  index_indents_on_district_id   (district_id)
#  index_indents_on_extension_id  (extension_id)
#  index_indents_on_region_id     (region_id)
#  index_indents_on_stock_id      (stock_id)
#
# Foreign Keys
#
#  fk_rails_...  (district_id => districts.id)
#  fk_rails_...  (extension_id => extensions.id)
#  fk_rails_...  (region_id => regions.id)
#  fk_rails_...  (stock_id => stocks.id)
#
FactoryBot.define do
  factory :indent do
    draft { false }
    state { 0 }
  end
end
