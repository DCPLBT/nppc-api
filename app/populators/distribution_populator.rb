# frozen_string_literal: true

class DistributionPopulator < BasePopulator
  attr_accessor :draft, :distributed, :received, :product_type_id, :product_id, :region_id, :district_id,
                :extension_id, :year, :distributed_type

  def run # rubocop:disable Metrics/AbcSize, Metrics/MethodLength
    distributions
      .public_send(:search, q)
      .yield_self { |distributions| filter_by_distributed(distributions) }
      .yield_self { |distributions| filter_by_received(distributions) }
      .yield_self { |distributions| filter_by_product_type(distributions) }
      .yield_self { |distributions| filter_by_product(distributions) }
      .yield_self { |distributions| filter_by_region(distributions) }
      .yield_self { |distributions| filter_by_district(distributions) }
      .yield_self { |distributions| filter_by_extension(distributions) }
      .yield_self { |distributions| filter_by_year(distributions) }
      .yield_self { |distributions| filter_by_date_range(distributions) }
      .yield_self { |distributions| filter_by_distributed_type(distributions) }
      .distinct
  end

  private

  def distributions
    @distributions ||= Distribution.includes(
      :line_items, :rich_text_received_remark, :region, :district, :extension, :distributed_tos, :distributors, :user,
      :requestable_requesters, :forwardable_forwarded_tos, :attachment, :company
    )
  end

  def filter_by_distributed(distributions)
    return distributions unless distributed.present? || determine_boolean(distributed)

    distributions.where(id: current_user.distributors_distributions.ids)
  end

  def filter_by_received(distributions)
    return distributions unless received.present? || determine_boolean(received)

    distributions.where(id: current_user.distributed_tos_distributions.ids)
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

  def filter_by_distributed_type(distributions)
    return distributions unless distributed_type.present?

    distributions.where(distributed_type: determine_distributed_type)
  end

  def determine_distributed_type
    distributed_type.presence_in(Distribution.distributed_types.keys) || :ea
  end
end
