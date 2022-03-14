# frozen_string_literal: true

require 'tempfile'

module Documents
  module Helpers
    class CustomTempFile < Tempfile
      def initialize(filename, temp_dir = nil)
        temp_dir ||= Dir.tmpdir
        extension = File.extname(filename)
        basename = File.basename(filename, extension)
        super([basename, extension], temp_dir)
      end
    end
  end
end
