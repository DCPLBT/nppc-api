# frozen_string_literal: true

class DistributionReportSerializer < ApplicationSerializer
  attributes(
    :product_type_id,
    :product_type_name,
    :product_id,
    :product_name,
    :quantity,
    :unit_price,
    :total_price
  )

  attribute :region_name do |obj|
    obj.itemable.region_name
  end
  attribute :district_name do |obj|
    obj.itemable.district_name
  end
  attribute :extension_name do |obj|
    obj.itemable.extension_name
  end
  attribute :company_name do |obj|
    obj.itemable.company_name
  end
  attribute :consumer_name do |obj|
    obj.itemable.consumer_name
  end
  attribute :consumer_cid do |obj|
    obj.itemable.consumer_cid
  end
  attribute :consumer_village do |obj|
    obj.itemable.consumer_village
  end
end
