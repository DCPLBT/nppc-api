module PreFilters
  def self.included(base)
    base.class_eval do
      before_action :authenticate_user!
    end
  end
end
