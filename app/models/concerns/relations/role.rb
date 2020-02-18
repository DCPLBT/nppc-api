module Relations
  module Role
    extend ActiveSupport::Concern

    included do
      has_and_belongs_to_many :users, inverse_of: :roles
    end
  end
end
