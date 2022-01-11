# frozen_string_literal: true

class BaseForm
  include Pundit
  include Assigner

  attr_accessor(
    :current_user,
    :include,
    :parent,
    :params,
    :id,
    :next_role_name,
    :current_role_name,
    :source_ids,
    :destination_ids
  )

  def initialize(attributes = {})
    assign_attributes(attributes)
  end
end
