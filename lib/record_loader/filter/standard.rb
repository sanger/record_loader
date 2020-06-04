# frozen_string_literal: true

module RecordLoader
  module Filter
    # Filters handle determining whether a file is loaded based on the environment
    # and WIP flags.
    class Standard
      #
      # Create a new standard filter
      #
      # @param dev [Boolean] Override the rails environment to generate (or not)
      #                      data from dev.yml files.
      # @param wip_list [Array<String>] An array of currently active WIP flags.
      #
      def initialize(dev:, wip_list:)
        @dev = dev
        @wip_list = wip_list
      end

      #
      # Indicates that a file should be loaded. Checks the environment flags
      # against the current environment, or if the file is flagged as WIP
      # check it against the active wip flags.
      #
      # @param [RecordLoader::RecordFile] file The file to check
      #
      # @return [Boolean] returns true if the file should be loaded
      #
      def include?(file)
        return @dev if file.dev?
        return @wip_list.include?(file.basename) if file.wip?

        true
      end
    end
  end
end
