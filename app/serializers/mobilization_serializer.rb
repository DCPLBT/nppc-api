# frozen_string_literal: true

# == Schema Information
#
# Table name: mobilizations
#
#  id             :bigint           not null, primary key
#  approved_on    :datetime
#  category       :integer
#  received_on    :datetime
#  reference_no   :string
#  rejected_on    :datetime
#  state          :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  approved_by_id :bigint
#  company_id     :bigint
#  district_id    :bigint
#  extension_id   :bigint
#  from_id        :bigint
#  received_by_id :bigint
#  region_id      :bigint
#  rejected_by_id :bigint
#  to_id          :bigint
#  user_id        :bigint           not null
#
# Indexes
#
#  index_mobilizations_on_approved_by_id  (approved_by_id)
#  index_mobilizations_on_company_id      (company_id)
#  index_mobilizations_on_district_id     (district_id)
#  index_mobilizations_on_extension_id    (extension_id)
#  index_mobilizations_on_from_id         (from_id)
#  index_mobilizations_on_received_by_id  (received_by_id)
#  index_mobilizations_on_region_id       (region_id)
#  index_mobilizations_on_rejected_by_id  (rejected_by_id)
#  index_mobilizations_on_to_id           (to_id)
#  index_mobilizations_on_user_id         (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (company_id => companies.id)
#  fk_rails_...  (district_id => districts.id)
#  fk_rails_...  (extension_id => extensions.id)
#  fk_rails_...  (region_id => regions.id)
#  fk_rails_...  (user_id => users.id)
#
class MobilizationSerializer < ApplicationSerializer
  attributes(
    :region_id,
    :region_name,
    :district_id,
    :district_name,
    :extension_id,
    :extension_name,
    :company_id,
    :company_name,
    :state,
    :reference_no,
    :category,
    :mobilizer_id,
    :mobilizer_name,
    :mobilizer_region_name,
    :mobilizer_district_name,
    :mobilizer_extension_name,
    :mobilizer_company_name,
    :mobilized_to_id,
    :mobilized_to_name,
    :mobilized_to_region_name,
    :mobilized_to_district_name,
    :mobilized_to_extension_name,
    :mobilized_to_company_name,
    :approved_by_id,
    :approved_by_name,
    :approved_on,
    :rejected_by_id,
    :rejected_by_name,
    :rejected_on,
    :received_by_id,
    :received_by_name,
    :received_on,
    :total_quantity,
    :total_price,
    :total_product,
    :created_at,
    :user_id,
    :user_name
  )

  has_one :attachment

  attribute :received_remark do |object|
    object.received_remark&.to_plain_text
  end

  attribute :rejected_remark do |object|
    object.rejected_remark&.to_plain_text
  end
end
