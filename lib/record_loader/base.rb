# frozen_string_literal: true

require 'yaml'

module RecordLoader
  # Inherit from RecordLoader base to automatically load one or more yaml files
  # into a @config hash. Config folders are found in config/default_records
  # and each loader should specify its own subfolder by setting the config_folder
  # class attribute.
  class Base
    # @return [Array] The default route to the yaml files containing the records
    #                 path is relative to the root directory of your application
    #                 and will contain a subfolder for each record loader.
    BASE_CONFIG_PATH = %w[config default_records].freeze

    class << self
      # @overload  config_folder(config_folder)
      #   Sets the folder, located under {BASE_CONFIG_PATH}, from which the records
      #   will be loaded.
      #
      #   @param [String] config_folder Set the config folder for the class
      #
      #   @return [String] The configured config folder
      #
      # @overload  config_folder
      #   Returns the folder, located under {BASE_CONFIG_PATH}, from which the records
      #   will be loaded.
      #
      #   @return [String] The configured config folder
      #
      def config_folder(config_folder = nil)
        @config_folder = config_folder unless config_folder.nil?
        @config_folder
      end

      # @overload  adapter(adapter)
      #   Sets the {RecordLoader::Adapter adapter} to use for the record loader, see the {RecordLoader::Adapter adapter}
      #   for further information.
      #
      #   @param [Object] adapter Set the adapter to use for the class
      #
      #   @return [Object] The configured adapter
      #
      # @overload  adapter
      #   Returns the configured adapter
      #
      #   @return [Object] The configured adapter
      #
      def adapter(adapter = nil)
        @adapter = adapter unless adapter.nil?
        @adapter || superclass.adapter
      end
    end

    adapter RecordLoader::Adapter::Basic.new

    #
    # Create a new config loader from yaml files
    #
    # @param files [Array<String>,NilClass] pass in an array of file names to load, or nil to load all files.
    #                                       Dev and wip flags will be ignored for files passed in explicitly
    # @param directory [Pathname, String] The directory from which to load the files.
    #   defaults to config/default_records/plate_purposes
    # @param dev [Boolean] Override the rails environment to generate (or not) data from dev.yml files.
    #
    def initialize(files: nil, directory: default_path, dev: adapter.development?)
      @path = directory.is_a?(Pathname) ? directory : Pathname.new(directory)

      list = Filter.create(files:, dev:, wip_list:)
      @files = @path.glob("*#{RecordFile::EXTENSION}")
                    .select { |child| list.include?(RecordFile.new(child)) }
      load_config
    end

    #
    # Opens a transaction and creates or updates each of the records in the yml files
    # via the #create_or_update! method
    #
    # @return [Void]
    def create!
      adapter.transaction do
        @config.each do |key, config|
          create_or_update!(key, config)
        rescue StandardError => e
          raise StandardError, "Failed to create #{key} due to: #{e.message}"
        end
      end
    end

    private

    #   Returns the configured adapter
    #
    #   @return [Object] The configured adapter
    #
    def adapter
      self.class.adapter
    end

    #
    # Returns the default route to the yaml files containing the records path
    # is relative to the root directory of your application and will contain a
    # subfolder for each record loader.
    #
    # Redefine this method in ApplicationRecordLoader to overide the default
    # configuration.
    #
    # @example
    #   RecordLoader::Base.base_config_path # => ['config', 'default_records']
    #
    # @return [Array] base path for record loader record
    #
    def base_config_path
      BASE_CONFIG_PATH
    end

    # Returns an array of WIP flags
    def wip_list
      ENV.fetch('WIP', '').split(',')
    end

    #
    # The default path to load config files from
    #
    # @return [Pathname] The directory containing the yml files
    #
    def default_path
      Pathname.pwd.join(*base_config_path, self.class.config_folder)
    end

    #
    # Load the appropriate configuration files into @config
    #
    def load_config
      @config = @files.each_with_object({}) do |file, store|
        latest_file = YAML.load_file(file, aliases: true)
        duplicate_keys = store.keys & latest_file.keys
        adapter.logger.warn "Duplicate keys in #{@path}: #{duplicate_keys}" unless duplicate_keys.empty?
        store.merge!(latest_file)
      end
    end
  end
end
