# frozen_string_literal: true

module Helpers
  module Profile
    extend ActiveSupport::Concern

    def name
      firstname || middlename || lastname ? "#{firstname} #{middlename} #{lastname}".squish : user.email
    end
  end
end
