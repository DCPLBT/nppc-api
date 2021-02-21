# frozen_string_literal: true

class ApplicationController < ActionController::API
  include Pundit
  include Renderer
  include Pagination
  include PreFilters
  include Pagy::Backend
  include ResourceFinder
  include ParamsSanitizer
  include ApiErrors::ErrorHandler
  include ActionController::Cookies
  include HttpAcceptLanguage::AutoLocale
  include ActionController::RequestForgeryProtection

  protect_from_forgery with: :exception
  skip_before_action :verify_authenticity_token
end
