# frozen_string_literal: true

# == Schema Information
#
# Table name: surrenders
#
#  id             :bigint           not null, primary key
#  reference_no   :string
#  state          :integer
#  surrender_type :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  district_id    :bigint
#  extension_id   :bigint
#  region_id      :bigint
#  user_id        :bigint           not null
#
# Indexes
#
#  index_surrenders_on_district_id   (district_id)
#  index_surrenders_on_extension_id  (extension_id)
#  index_surrenders_on_region_id     (region_id)
#  index_surrenders_on_user_id       (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (district_id => districts.id)
#  fk_rails_...  (extension_id => extensions.id)
#  fk_rails_...  (region_id => regions.id)
#  fk_rails_...  (user_id => users.id)
#
class SurrenderSerializer < ApplicationSerializer
  attributes(
    :region_id,
    :region_name,
    :district_id,
    :district_name,
    :extension_id,
    :extension_name,
    :state,
    :reference_no,
    :surrender_type,
    :surrenderer_id,
    :surrenderer_name,
    :surrenderer_region_name,
    :surrenderer_district_name,
    :surrenderer_extension_name,
    :surrendered_to_id,
    :surrendered_to_name,
    :surrendered_to_region_name,
    :surrendered_to_district_name,
    :surrendered_to_extension_name,
    :total_quantity,
    :total_price,
    :total_product,
    :created_at
  )

  has_one :attachment

  attribute :received_remark do |object|
    object.received_remark&.to_plain_text
  end

  attribute :comments do |object|
    object.comments&.to_plain_text
  end
end
