# frozen_string_literal: true

module Documents
  module Pdf
    class Surrender < Base
      attr_accessor :surrenders

      def data
        { surrenders: surrenders }
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
