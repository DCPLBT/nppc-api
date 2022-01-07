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
    :next_role_name
  )
  attr_reader :current_role_name

  def initialize(attributes = {})
    assign_attributes(attributes)
  end

  def current_role_name=(role)
    @current_role_name = role.nil? ? current_user.roles.first.name&.delete(' ')&.underscore : role
  end
end
