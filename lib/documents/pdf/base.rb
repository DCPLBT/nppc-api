# frozen_string_literal: true

module Documents
  module Pdf
    class Base
      include Assigner
      include Documents::TemplateRenderer

      def initialize(attributes = {})
        assign_attributes(attributes)
      end

      def generate # rubocop:disable Metrics/MethodLength
        pdf = WickedPdf.new.pdf_from_string(
          render_template,
          orientation: 'Portrait',
          page_size: page_size,
          dpi: 96,
          lowquality: false,
          image_quality: 500,
          viewport_size: viewport_size,
          margin: margin,
          encoding: 'utf-8',
          header: {
            spacing: 10,
            content: render_header
          },
          footer: {
            content: render_footer
          }
        )
        save_path = Rails.root.join('public', 'test.pdf')
        File.open(save_path, 'wb') do |file|
          file << pdf
        end
        save_path
      end

      def render_template
        TemplateRenderer.render(
          templates_path: 'lib/documents/templates',
          template: template_filename,
          layout: layout,
          data: data
        )
      end

      def render_header
        TemplateRenderer.render(
          template: header_template,
          layout: plain_layout,
          data: data
        )
      end

      def render_footer
        TemplateRenderer.render(
          template: footer_template,
          layout: layout,
          data: data
        )
      end

      def data
        raise NotImplementedError
      end

      def layout
        'layout/pdf'
      end

      def plain_layout
        'layout/plain'
      end

      def header_template
        'layout/_header'
      end

      def footer_template
        'layout/_footer'
      end

      def template_filename
        class_name = self.class.name.demodulize
        class_name.underscore
      end

      def margin
        { right: 15, left: 15, top: 38, bottom: 25 }
      end

      def page_size
        'A4'
      end

      def viewport_size
        '794x1123'
      end
    end
  end
end
