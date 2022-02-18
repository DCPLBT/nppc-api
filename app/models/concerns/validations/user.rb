# frozen_string_literal: true

module Validations
  module User
    extend ActiveSupport::Concern

    included do
      validates_presence_of :email, :roles, :profile
      validates_uniqueness_of :email, :username, :phone, allow_blank: true
    end
  end
end
