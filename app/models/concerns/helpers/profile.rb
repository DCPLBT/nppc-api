# frozen_string_literal: true

module Helpers
  module Profile
    extend ActiveSupport::Concern

    def name
      firstname || lastname ? "#{firstname} #{lastname}" : user.email
    end
  end
end
