# frozen_string_literal: true

require 'rubyXL/convenience_methods'

module Documents
  module Excel
    class ExcelRenderer
      attr_accessor :sheet, :header, :data, :name

      def initialize(header, data, name)
        @header = header
        @data = data
        @name = name
      end

      def run
        write_data
      end

      private

      def write_data
        book = RubyXL::Workbook.new
        @sheet = book.worksheets[0]
        populate_header
        populate_body

        tmp = Helpers::CustomTempFile.new("#{name}.xlsx")
        book.write tmp.path
        tmp.path
      end

      def populate_header # rubocop:disable Metrics/AbcSize
        sheet.change_row_fill(0, 'C5C9C7')
        header.each_with_index do |name, index|
          sheet.add_cell(0, index, name)
          sheet.sheet_data[0][index].change_font_bold(true)
          sheet.sheet_data[0][index].change_text_wrap(true)
          sheet.sheet_data[0][index].change_vertical_alignment('center')
          sheet.sheet_data[0][index].change_horizontal_alignment('center')
          sheet.change_column_width(index, name.size + 5)
        end
      end

      def populate_body
        data.each_with_index do |job, i|
          header.each_with_index do |_name, j|
            sheet.add_cell(i + 1, j, job[j])
            sheet.sheet_data[i + 1][j].change_text_wrap(true)
          end
        end
      end
    end
  end
end
