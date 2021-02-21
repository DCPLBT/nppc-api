# frozen_string_literal: true

module Validations
  module Attachment
    extend ActiveSupport::Concern

    included do
      validates_presence_of :file
      validate :file_content_type
      validate :attached_file_size
    end

    def file_content_type
      errors.add(:file, :file_is_not_correct) unless correct_file_type?
    end

    def attached_file_size
      return unless file.attached?

      errors.add(:base, :max_size_exceeded) if file.byte_size > 5.megabytes
    end
  end
end
