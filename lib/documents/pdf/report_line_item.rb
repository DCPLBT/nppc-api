# frozen_string_literal: true

module Documents
  module Pdf
    class ReportLineItem < Base
      attr_accessor :line_items

      def data
        { line_items: line_items }
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
