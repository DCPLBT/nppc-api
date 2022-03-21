# frozen_string_literal: true

class IndentReportPopulator < ReportPopulator
  def run
    @type = 'Indent'
    super
  end

  private

  def received_line_items(line_items)
    items(line_items).where(
      "#{type.underscore.pluralize}": {
        id: groups.includes(:forwarded_indents).flat_map(&:forwarded_indents).pluck(:id)
      }
    )
  end

  def submitted_line_items(line_items)
    items(line_items).where(
      "#{type.underscore.pluralize}": {
        id: groups.includes(:requested_indents).flat_map(&:requested_indents).pluck(:id)
      }
    )
  end

  def filter_by_region(line_items)
    return line_items unless region_id.present?

    if submitted.present? && determine_boolean(submitted)
      from_indents(line_items).where(groups: { region_id: region_id })
    else
      to_indents(line_items).where(groups: { region_id: region_id })
    end
  end

  def filter_by_district(line_items)
    return line_items unless district_id.present?

    if submitted.present? && determine_boolean(submitted)
      from_indents(line_items).where(groups: { district_id: district_id })
    else
      to_indents(line_items).where(groups: { district_id: district_id })
    end
  end

  def filter_by_extension(line_items)
    return line_items unless extension_id.present?

    if submitted.present? && determine_boolean(submitted)
      from_indents(line_items).where(groups: { extension_id: extension_id })
    else
      to_indents(line_items).where(groups: { extension_id: extension_id })
    end
  end

  def from_indents(line_items)
    @from_indents ||= items(line_items).joins(
      "INNER JOIN transaction_froms ON transactionable_type='Indent' AND "\
      "transactionable_id=#{type.underscore.pluralize}.id INNER JOIN groups ON groups.id=transaction_froms.from_id"
    )
  end

  def to_indents(line_items)
    @to_indents ||= items(line_items).joins(
      "INNER JOIN transaction_tos ON transactionable_type='Indent' AND "\
      "transactionable_id=#{type.underscore.pluralize}.id INNER JOIN groups ON groups.id=transaction_tos.to_id"
    )
  end
end
