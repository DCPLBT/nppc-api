# frozen_string_literal: true

module Documents
  module Zip
    class ZipRenderer
      attr_accessor :name, :documents

      def initialize(documents, name)
        @documents = documents
        @name = name
      end

      def run
        process_and_create_zip_file
      end

      private

      def process_and_create_zip_file # rubocop:disable Metrics/AbcSize
        tmp_user_folder = "tmp/zip/#{name}"
        dir_length_same_as_documents = Dir["#{tmp_user_folder}/*"].length == documents.length
        FileUtils.mkdir_p(tmp_user_folder) unless Dir.exist?(tmp_user_folder)

        documents.each do |document|
          filename = "#{document.id}#{document.blob.filename}"

          store_documents(document, tmp_user_folder, filename) unless dir_length_same_as_documents
          create_zip_from_tmp_folder(tmp_user_folder, filename) unless dir_length_same_as_documents
        end
        Rails.root.join("#{tmp_user_folder}.zip")
      end

      def store_documents(document, tmp_user_folder, filename)
        ::File.open(File.join(tmp_user_folder, filename), 'wb') do |file|
          document.download { |chunk| file.write(chunk) }
        end
      end

      def create_zip_from_tmp_folder(tmp_user_folder, filename)
        ::Zip::File.open("#{tmp_user_folder}.zip", ::Zip::File::CREATE) do |zf|
          zf.add(filename, "#{tmp_user_folder}/#{filename}")
        end
      end
    end
  end
end
