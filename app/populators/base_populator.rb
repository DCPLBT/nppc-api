# frozen_string_literal: true

class BasePopulator
  include Assigner

  attr_accessor :current_user, :current_role, :current_role_name, :parent, :q, :from_date, :to_date, :current_group,
                :disabled

  def initialize(attrs = {})
    assign_attributes(attrs)
  end

  def determine_boolean(status)
    [true, 'true'].include?(status)
  end

  def valid_dates? # rubocop:disable Metrics/CyclomaticComplexity
    return if from_date.nil? || from_date&.empty?
    return if to_date.nil? || to_date&.empty?
    return true if date(from_date) <= (date(to_date))

    raise ActiveRecord::RecordNotSaved, '"From date" should be before or same as "to date"'
  end

  def date(val)
    val&.to_date || Time.current
  end

  def filter_by_date_range(lists)
    return lists unless valid_dates?

    lists.where(created_at: date(from_date).beginning_of_day..date(to_date).end_of_day)
  end

  def filter_by_disabled(lists)
    return lists unless disabled.present?

    lists.where(disabled: determine_boolean(disabled))
  end
end
