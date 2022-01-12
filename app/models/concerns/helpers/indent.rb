# frozen_string_literal: true

module Helpers
  module Indent
    extend ActiveSupport::Concern

    def requester
      @requester ||= requesters.includes(:profile).last
    end

    def forwarded_to
      @forwarded_to ||= forwarded_tos.includes(:profile).last
    end
  end
end
