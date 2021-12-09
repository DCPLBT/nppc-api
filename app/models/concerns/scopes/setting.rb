# frozen_string_literal: true

module Scopes
  module Setting
    extend ActiveSupport::Concern

    included do
      default_scope -> { order(created_at: :desc) }
    end
  end
end
