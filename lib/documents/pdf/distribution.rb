# frozen_string_literal: true

module Documents
  module Pdf
    class Distribution < Base
      attr_accessor :distributions

      def data
        { distributions: distributions }
      end

      def header_template
        'layout/_empty'
      end

      def margin
        { right: 15, left: 15, top: 15, bottom: 15 }
      end
    end
  end
end
