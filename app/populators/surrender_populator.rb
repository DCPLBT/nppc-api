# frozen_string_literal: true

class SurrenderPopulator < BasePopulator
  attr_accessor :surrendered, :received, :product_type_id, :product_id, :region_id, :district_id,
                :extension_id, :year

  def run # rubocop:disable Metrics/AbcSize, Metrics/MethodLength
    surrenders
      .public_send(:search, q)
      .yield_self { |surrenders| filter_by_surrendered(surrenders) }
      .yield_self { |surrenders| filter_by_received(surrenders) }
      .yield_self { |surrenders| filter_by_product_type(surrenders) }
      .yield_self { |surrenders| filter_by_product(surrenders) }
      .yield_self { |surrenders| filter_by_region(surrenders) }
      .yield_self { |surrenders| filter_by_district(surrenders) }
      .yield_self { |surrenders| filter_by_extension(surrenders) }
      .yield_self { |surrenders| filter_by_year(surrenders) }
      .distinct
  end

  private

  def surrenders
    @surrenders ||= Surrender.includes(
      :line_items, :rich_text_received_remark, :region, :district, :extension,
      :requestable_requesters, :forwardable_forwarded_tos, :attachment,
      surrendered_tos: :profile, surrenderers: :profile
    )
  end

  def filter_by_surrendered(surrenders)
    return surrenders unless surrendered.present? || determine_boolean(surrendered)

    surrenders.where(id: current_user.surrenderer_products.ids)
  end

  def filter_by_received(surrenders)
    return surrenders unless received.present? || determine_boolean(received)

    surrenders.where(id: current_user.surrendered_to_products.ids)
  end

  def filter_by_product_type(surrenders)
    return surrenders unless product_type_id.present?

    surrenders.filter_by_product_type(product_type_id)
  end

  def filter_by_product(surrenders)
    return surrenders unless product_id.present?

    surrenders.filter_by_product(product_id)
  end

  def filter_by_region(surrenders)
    return surrenders unless region_id.present?

    surrenders.filter_by_region(region_id)
  end

  def filter_by_district(surrenders)
    return surrenders unless district_id.present?

    surrenders.filter_by_district(district_id)
  end

  def filter_by_extension(surrenders)
    return surrenders unless extension_id.present?

    surrenders.filter_by_extension(extension_id)
  end

  def filter_by_year(surrenders)
    return surrenders unless year.present?

    surrenders.where(created_at: Date.new(year.to_i).all_year)
  end
end
