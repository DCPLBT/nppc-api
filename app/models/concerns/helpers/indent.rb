# frozen_string_literal: true

module Helpers
  module Indent
    extend ActiveSupport::Concern

    def requester
      @requester ||= requesters.last
    end

    def forwarded_to
      @forwarded_to ||= forwarded_tos.last
    end
  end
end
