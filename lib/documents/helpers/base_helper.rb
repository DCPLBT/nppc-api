# frozen_string_literal: true

module Documents
  module Helpers
    module BaseHelper
      def host_url(request)
        request_with_protocol = "#{request.protocol}#{request.host}"
        Rails.env.production? ? request_with_protocol : "#{request_with_protocol}:3000"
      end
    end
  end
end
