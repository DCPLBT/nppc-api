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
class IndentSerializer < ApplicationSerializer
  attributes(
    :requester_id,
    :requester_name,
    :requester_region_name,
    :requester_district_name,
    :requester_extension_name,
    :forwarded_to_id,
    :forwarded_to_name,
    :forwarded_to_region_name,
    :forwarded_to_district_name,
    :forwarded_to_extension_name,
    :draft,
    :state,
    :reference_no,
    :created_at,
    :region_name,
    :district_name,
    :extension_name
  )

  attribute :remark do |object|
    object.remark&.to_s
  end

  attribute :total_product do |object|
    object.line_items&.size
  end

  attribute :total_quantity do |object|
    object.line_items&.sum(&:quantity)
  end
end
