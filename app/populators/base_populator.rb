class BasePopulator
  include Assigner

  attr_accessor :current_user, :parent

  def initialize(attrs = {})
    assign_attributes(attrs)
  end
end
