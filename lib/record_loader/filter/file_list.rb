# frozen_string_literal: true

module RecordLoader
  module Filter
    # FileList Filters handle determining whether a file is loaded based on the
    # Supplied lift of files. WIP and environment flags are ignored.
    class FileList
      #
      # Create a new FileList filter
      #
      # @param files [Array<String>,NilClass] pass in an array of file names to load, or nil to load all files.
      #
      def initialize(file_list)
        @file_list = file_list
      end

      #
      # Indicates that a file should be loaded. Compares the files base_name
      # (ie. the name excluding extensions or wip/environment flags) against the
      # provided list.
      #
      # @param [RecordLoader::RecordFile] file The file to check
      #
      # @return [Boolean] returns true if the file should be loaded
      #
      def include?(file)
        @file_list.include?(file.basename)
      end
    end
  end
end
