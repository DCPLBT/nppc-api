module Validations
  module User
    extend ActiveSupport::Concern

    included do
      validates :phone, :email, presence: true
    end
  end
end
