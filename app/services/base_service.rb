# frozen_string_literal: true

class BaseService
  include Assigner
  include Rails.application.routes.url_helpers

  attr_accessor(
    :params
  )

  def initialize(attributes = {})
    assign_attributes(attributes)
  end
end
