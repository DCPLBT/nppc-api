module Validations
  module Attachment
    extend ActiveSupport::Concern

    included do
      validates_presence_of :file
      validate :file_content_type
    end

    def file_content_type
      errors.add(:file, :file_is_not_correct) unless correct_file_type?
    end
  end
end
