# frozen_string_literal: true

module RecordLoader
  # A RecordFile is a wrapper to handle categorization of the yaml files
  # used by RecordLoader
  class RecordFile
    # @return [String] Extension of the yaml files to load.
    EXTENSION = '.yml'
    # @return [String] The tag immediately prior to the extension that flags a
    #                  file as being development specific. For example a file
    #                  names users.dev.yaml
    DEV_IDENTIFIER = '.dev'
    # @return [String] The tag immediately prior to the extension that flags a
    #                  file as being work-in-progress. For example a file
    #                  names new_feature.wip.yaml
    WIP_IDENTIFIER = '.wip'

    # Create a RecordFile wrapper for a given file
    # @param record_file [Pathname] The path of the file to wrap
    def initialize(record_file)
      @record_file = record_file
    end

    # Returns the name of the file, minus the extension and dev/wip flags
    # @return [String] The name of the file eg. "000_purpose"
    def basename
      without_extension.delete_suffix(WIP_IDENTIFIER)
                       .delete_suffix(DEV_IDENTIFIER)
    end

    # Returns true if the file is development environment specific
    # ie. ends in .dev.yml
    # @return [Boolean] True if the file is a dev file
    def dev?
      without_extension.end_with?(DEV_IDENTIFIER)
    end

    # Returns true if the file is flagged as WIP
    # ie. ends in .wip.yml
    # @return [Boolean] True if the file is a wip file
    def wip?
      without_extension.end_with?(WIP_IDENTIFIER)
    end

    private

    def without_extension
      @record_file.basename(EXTENSION).to_s
    end
  end
end
