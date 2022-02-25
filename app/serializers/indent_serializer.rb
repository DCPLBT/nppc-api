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
#  company_id   :bigint
#  district_id  :bigint
#  extension_id :bigint
#  from_id      :bigint
#  region_id    :bigint
#  to_id        :bigint
#  user_id      :bigint           not null
#
# Indexes
#
#  index_indents_on_company_id    (company_id)
#  index_indents_on_district_id   (district_id)
#  index_indents_on_extension_id  (extension_id)
#  index_indents_on_region_id     (region_id)
#  index_indents_on_user_id       (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (company_id => companies.id)
#  fk_rails_...  (district_id => districts.id)
#  fk_rails_...  (extension_id => extensions.id)
#  fk_rails_...  (region_id => regions.id)
#  fk_rails_...  (user_id => users.id)
#
class IndentSerializer < ApplicationSerializer
  attributes(
    :requester_id,
    :requester_name,
    :requester_region_name,
    :requester_district_name,
    :requester_extension_name,
    :requester_company_name,
    :forwarded_to_id,
    :forwarded_to_name,
    :forwarded_to_region_name,
    :forwarded_to_district_name,
    :forwarded_to_company_name,
    :draft,
    :state,
    :reference_no,
    :created_at,
    :region_name,
    :district_name,
    :extension_name,
    :company_name
  )

  attribute :remark do |object|
    object.remark&.to_plain_text
  end

  attribute :total_product do |object|
    object.line_items&.size
  end

  attribute :total_quantity do |object|
    object.line_items&.sum(&:quantity)
  end
end
