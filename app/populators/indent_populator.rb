# frozen_string_literal: true

class IndentPopulator < BasePopulator
  attr_accessor :draft, :requested, :received, :product_type_id, :product_id, :region_id, :district_id,
                :extension_id, :year

  def run # rubocop:disable Metrics/MethodLength,Metrics/AbcSize
    indents
      .public_send(:search, q)
      .yield_self { |indents| filter_by_draft(indents) }
      .yield_self { |indents| filter_by_requested(indents) }
      .yield_self { |indents| filter_by_received(indents) }
      .yield_self { |indents| filter_by_product_type(indents) }
      .yield_self { |indents| filter_by_product(indents) }
      .yield_self { |indents| filter_by_region(indents) }
      .yield_self { |indents| filter_by_district(indents) }
      .yield_self { |indents| filter_by_extension(indents) }
      .yield_self { |indents| filter_by_year(indents) }
      .yield_self { |indents| filter_by_date_range(indents) }
  end

  private

  def indents
    @indents ||= Indent.includes(
      :line_items, :rich_text_remark, :region, :district, :extension, :forwarded_tos, :requesters,
      :requestable_requesters, :forwardable_forwarded_tos, :company
    )
  end

  def filter_by_draft(indents)
    return indents unless draft.present?

    indents.where(draft: determine_boolean(draft))
  end

  def filter_by_requested(indents)
    return indents unless requested.present? || determine_boolean(requested)

    indents.where(id: current_user.requested_indents.ids)
  end

  def filter_by_received(indents)
    return indents unless received.present? || determine_boolean(received)

    indents.where(id: current_user.forwarded_indents.ids)
  end

  def filter_by_product_type(indents)
    return indents unless product_type_id.present?

    indents.filter_by_product_type(product_type_id)
  end

  def filter_by_product(indents)
    return indents unless product_id.present?

    indents.filter_by_product(product_id)
  end

  def filter_by_region(indents)
    return indents unless region_id.present?

    indents.filter_by_region(region_id)
  end

  def filter_by_district(indents)
    return indents unless district_id.present?

    indents.filter_by_district(district_id)
  end

  def filter_by_extension(indents)
    return indents unless extension_id.present?

    indents.filter_by_extension(extension_id)
  end

  def filter_by_year(indents)
    return indents unless year.present?

    indents.where(created_at: Date.new(year.to_i).all_year)
  end

  def filter_by_date_range(indents)
    return indents unless valid_dates?

    indents.where(created_at: date(from_date).beginning_of_day..date(to_date).end_of_day)
  end
end
