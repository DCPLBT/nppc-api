# frozen_string_literal: true

module Scopes
  module Group
    extend ActiveSupport::Concern

    included do
      default_scope -> { includes(:region, :district, :extension, :village, :company) }
    end
  end
end
