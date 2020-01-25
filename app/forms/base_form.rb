class BaseForm
  include Pundit
  include Assigner

  attr_accessor(
    :current_user,
    :params,
    :id
  )

  def initialize(attributes = {})
    assign_attributes(attributes)
  end
end
