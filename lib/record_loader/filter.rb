# frozen_string_literal: true

require_relative 'filter/file_list'
require_relative 'filter/standard'

module RecordLoader
  #
  # {RecordLoader::Filter}s provide a means of determining if a file should be
  # loaded. This is currently an internal mechanism, and no interface is
  # provided for adding your own filters.
  #
  # = Existing Filters
  # There are currently two adapters used
  #
  # - {RecordLoader::Filter::Standard}
  # The default filter. Loads files based on environment and WIP flags. Used by
  # {RecordLoader::Base} if no list of files is supplied.
  #
  # - {RecordLoader::Filter::FileList}
  # Filters files solely based on a supplied list. Used by {RecordLoader::Base}
  # if a list of files is supplied. Overides wip flag and environment specific
  # behaviour.
  #
  # = Custom Filters
  # There is currently no support for custom filters.
  #
  module Filter
    # Returns the appropriate filter for the provided arguments:
    # - {RecordLoader::Filter::FileList}
    # If a list of files is supplied
    # - {RecordLoader::Filter::Standard}
    # Otherwise
    #
    # @param files [Array<String>,NilClass] pass in an array of file names to load, or nil to load all files.
    #                                       Dev and wip flags will be ignored for files passed in explicitly
    # @param dev [Boolean] Override the rails environment to generate (or not)
    #                      data from dev.yml files.
    # @param, wip_list [Array<String>] An array of currently active WIP flags.
    # @return [RecordLoader::Filter::Standard, RecordLoader::Filter::FileList] An appropriate filter
    def self.create(files: nil, dev: false, wip_list: [])
      if files.nil?
        RecordLoader::Filter::Standard.new(dev: dev, wip_list: wip_list)
      else
        RecordLoader::Filter::FileList.new(files)
      end
    end
  end
end
