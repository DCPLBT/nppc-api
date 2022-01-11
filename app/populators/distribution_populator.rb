# frozen_string_literal: true

class DistributionPopulator < BasePopulator
  attr_accessor :draft, :requested, :received, :product_type_id, :product_id, :region_id, :district_id,
                :extension_id, :year

  def run # rubocop:disable Metrics/MethodLength,Metrics/AbcSize
    distributions
      .public_send(:search, q)
      .yield_self { |distributions| filter_by_draft(distributions) }
      .yield_self { |distributions| filter_by_requested(distributions) }
      .yield_self { |distributions| filter_by_received(distributions) }
      .yield_self { |distributions| filter_by_product_type(distributions) }
      .yield_self { |distributions| filter_by_product(distributions) }
      .yield_self { |distributions| filter_by_region(distributions) }
      .yield_self { |distributions| filter_by_district(distributions) }
      .yield_self { |distributions| filter_by_extension(distributions) }
      .yield_self { |distributions| filter_by_year(distributions) }
  end

  private

  def distributions
    @distributions ||= Distribution.includes(
      :line_items, :rich_text_remark, :region, :district, :extension, :forwarded_tos, :requesters,
      :requestable_requesters, :forwardable_forwarded_tos
    )
  end

  def filter_by_draft(distributions)
    return distributions unless draft.present?

    distributions.where(draft: determine_boolean(draft))
  end

  def filter_by_requested(distributions)
    return distributions unless requested.present? || determine_boolean(requested)

    distributions.where(id: current_user.requested_distributions.ids)
  end

  def filter_by_received(distributions)
    return distributions unless received.present? || determine_boolean(received)

    distributions.where(id: current_user.forwarded_distributions.ids)
  end

  def filter_by_product_type(distributions)
    return distributions unless product_type_id.present?

    distributions.filter_by_product_type(product_type_id)
  end

  def filter_by_product(distributions)
    return distributions unless product_id.present?

    distributions.filter_by_product(product_id)
  end

  def filter_by_region(distributions)
    return distributions unless region_id.present?

    distributions.filter_by_region(region_id)
  end

  def filter_by_district(distributions)
    return distributions unless district_id.present?

    distributions.filter_by_district(district_id)
  end

  def filter_by_extension(distributions)
    return distributions unless extension_id.present?

    distributions.filter_by_extension(extension_id)
  end

  def filter_by_year(distributions)
    return distributions unless year.present?

    distributions.where(created_at: Date.new(year.to_i).all_year)
  end
end
