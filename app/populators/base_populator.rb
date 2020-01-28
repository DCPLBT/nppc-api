class BasePopulator
  include Assigner

  attr_accessor :current_user

  def initialize(attrs = {})
    assign_attributes(attrs)
  end
end
