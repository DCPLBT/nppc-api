# frozen_string_literal: true

class BasePopulator
  include Assigner

  attr_accessor :current_user, :parent, :q

  def initialize(attrs = {})
    assign_attributes(attrs)
  end

  def determine_boolean(status)
    [true, 'true'].include?(status)
  end
end
