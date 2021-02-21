# frozen_string_literal: true

module Relations
  module Attachment
    extend ActiveSupport::Concern

    included do
      belongs_to :attachable, polymorphic: true

      has_one_attached :file, dependent: :destroy
    end
  end
end
