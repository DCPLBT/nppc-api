# frozen_string_literal: true

module Documents
  module TemplateRenderer
    # Renders a view.
    def self.render(options = {})
      # Pass a hash of local variables as :assigns.
      data = options.delete(:data) || {}

      templates_path = options.delete(:templates_path) || 'lib/documents/templates'

      # Create a view.
      view = view_class.new(
        ActionView::LookupContext.new(templates_path),
        data,
        ActionController::Base.new
      )

      # Mix in other supports you need.
      view.extend(ApplicationHelper)

      # Render.
      view.render(options)
    end

    # Creates a subclass of ActionView::Base with route supports mixed in.
    def self.view_class # rubocop:disable Metrics/MethodLength, Metrics/AbcSize
      @view_class ||= Class.new ActionView::Base do
        include Rails.application.routes.url_helpers

        def default_url_options(options = {})
          Rails.application.config.action_mailer.default_url_options(options)
        end

        def compiled_method_container
          self.class
        end

        def document_stylesheet_link_tag(*sources)
          css_dir = WickedPdf::WickedPdfHelper.root_path.join('lib', 'documents', 'assets', 'css')
          css_text = sources.collect do |source|
            source = WickedPdf::WickedPdfHelper.add_extension(source, 'css')
            "<style type='text/css'>#{File.read(css_dir.join(source))}</style>"
          end.join("\n")
          css_text.respond_to?(:html_safe) ? css_text.html_safe : css_text
        end

        def document_image_tag(img, options = {})
          image_tag(
            "file:///#{WickedPdf::WickedPdfHelper.root_path.join('lib', 'documents', 'assets', 'images', img)}",
            options
          )
        end
      end
    end
  end
end
