# frozen_string_literal: true

module Relations
  module User
    extend ActiveSupport::Concern

    included do
      has_and_belongs_to_many :roles, inverse_of: :users
    end
  end
end
