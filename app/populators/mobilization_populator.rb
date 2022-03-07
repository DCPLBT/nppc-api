# frozen_string_literal: true

class MobilizationPopulator < BasePopulator
  attr_accessor :mobilized, :received, :product_type_id, :product_id, :region_id, :district_id,
                :extension_id, :year, :approved, :rejected

  def run # rubocop:disable Metrics/AbcSize, Metrics/MethodLength
    mobilizations
      .public_send(:search, q)
      .yield_self { |mobilizations| filter_by_mobilized(mobilizations) }
      .yield_self { |mobilizations| filter_by_received(mobilizations) }
      .yield_self { |mobilizations| filter_by_product_type(mobilizations) }
      .yield_self { |mobilizations| filter_by_product(mobilizations) }
      .yield_self { |mobilizations| filter_by_region(mobilizations) }
      .yield_self { |mobilizations| filter_by_district(mobilizations) }
      .yield_self { |mobilizations| filter_by_extension(mobilizations) }
      .yield_self { |mobilizations| filter_by_year(mobilizations) }
      .yield_self { |mobilizations| filter_by_approved(mobilizations) }
      .yield_self { |mobilizations| filter_by_rejected(mobilizations) }
      .yield_self { |mobilizations| filter_by_date_range(mobilizations) }
      .distinct
  end

  private

  def mobilizations
    @mobilizations ||= Mobilization.includes(
      :line_items, :rich_text_received_remark, :region, :district, :extension, :mobilized_tos, :mobilizers, :user,
      :requestable_requesters, :forwardable_forwarded_tos, :attachment, :company, :approved_by, :received_by
    )
  end

  def filter_by_mobilized(mobilizations)
    return mobilizations unless mobilized.present? || determine_boolean(mobilized)

    mobilizations.where(id: current_user.mobilizers_mobilizations.ids)
  end

  def filter_by_received(mobilizations)
    return mobilizations unless received.present? || determine_boolean(received)

    mobilizations.where(id: current_user.mobilized_tos_mobilizations.ids)
  end

  def filter_by_product_type(mobilizations)
    return mobilizations unless product_type_id.present?

    mobilizations.filter_by_product_type(product_type_id)
  end

  def filter_by_product(mobilizations)
    return mobilizations unless product_id.present?

    mobilizations.filter_by_product(product_id)
  end

  def filter_by_region(mobilizations)
    return mobilizations unless region_id.present?

    mobilizations.filter_by_region(region_id)
  end

  def filter_by_district(mobilizations)
    return mobilizations unless district_id.present?

    mobilizations.filter_by_district(district_id)
  end

  def filter_by_extension(mobilizations)
    return mobilizations unless extension_id.present?

    mobilizations.filter_by_extension(extension_id)
  end

  def filter_by_year(mobilizations)
    return mobilizations unless year.present?

    mobilizations.where(created_at: Date.new(year.to_i).all_year)
  end

  def filter_by_approved(mobilizations)
    return mobilizations unless approved.present? || determine_boolean(approved)

    mobilizations.where(state: :approved)
  end

  def filter_by_rejected(mobilizations)
    return mobilizations unless rejected.present? || determine_boolean(rejected)

    mobilizations.where(state: :rejected)
  end
end
