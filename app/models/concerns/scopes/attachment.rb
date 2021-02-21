# frozen_string_literal: true

module Scopes
  module Attachment
    extend ActiveSupport::Concern

    included do
      default_scope -> { includes(file_attachment: :blob) }
    end
  end
end
