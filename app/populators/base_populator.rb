# frozen_string_literal: true

class BasePopulator
  include Assigner

  attr_accessor :current_user, :parent, :q, :from_date, :to_date

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

    raise ArgumentError, '"From date" should be before or same as "to date"'
  end

  def date(val)
    val&.to_date || Time.current
  end
end
