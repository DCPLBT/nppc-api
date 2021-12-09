# frozen_string_literal: true

class SettingPopulator < BasePopulator
  attr_accessor :category

  CATEGORY_LIST = %w[indent obsolete].freeze

  def run
    settings
      .yield_self { |settings| filter_by_category(settings) }
  end

  private

  def settings
    @settings ||= parent ? parent.settings : Setting
  end

  def filter_by_category(settings)
    settings.where(category: find_category)
  end

  def find_category
    category.presence_in(CATEGORY_LIST) || :indent
  end
end
