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

  attribute :region_name do |obj, params|
    if bool(params[:submitted])
      obj.itemable.distributor&.region_name
    else
      obj.itemable.region_name
    end
  end
  attribute :district_name do |obj, params|
    if bool(params[:submitted])
      obj.itemable.distributor&.district_name
    else
      obj.itemable.district_name
    end
  end
  attribute :extension_name do |obj, params|
    if bool(params[:submitted])
      obj.itemable.distributor&.extension_name
    else
      obj.itemable.extension_name
    end
  end
  attribute :company_name do |obj, params|
    if bool(params[:submitted])
      obj.itemable.distributor&.company_name
    else
      obj.itemable.company_name
    end
  end
  attribute :consumer_name do |obj|
    obj.itemable.consumer_name
  end
  attribute :consumer_cid do |obj|
    obj.itemable.consumer_cid
  end
  attribute :consumer_village do |obj, params|
    if bool(params[:submitted])
      obj.itemable.distributor&.village_name
    else
      obj.itemable&.village_name
    end
  end

  def self.bool(val)
    [true, 'true'].include?(val)
  end
end
