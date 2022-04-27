# frozen_string_literal: true

class ApplicationController < ActionController::API
  include Renderer
  include CartHelper
  include Pagination
  include PreFilters
  include Pagy::Backend
  include ResourceFinder
  include ParamsSanitizer
  include Pundit::Authorization
  include ApiErrors::ErrorHandler
  include ActionController::Cookies
  include HttpAcceptLanguage::AutoLocale
  include ActionController::RequestForgeryProtection

  protect_from_forgery with: :exception
  skip_before_action :verify_authenticity_token

  def after_sign_in_path_for(resource_or_scope)
    stored_location_for(resource_or_scope) || root_path
  end
end
