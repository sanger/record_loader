# frozen_string_literal: true

require 'logger'

module RecordLoader
  module Adapter
    #
    # A very basic {RecordLoader::Adapter} which provides limited logging
    # functionality, environment is extracted from RACK_ENV
    #
    class Basic
      attr_reader :logger

      #
      # Create a new {RecordLoader::Adapter::Basic}. Can pass in a pre-existing
      # logger is required.
      # @see https://ruby-doc.org/stdlib-2.5.0/libdoc/logger/rdoc/Logger.html
      #
      # @param [#debug&#info&#warn#&error&#fatal] logger Optional logger object. Creates a new ruby Logger by default.
      #
      def initialize(logger: Logger.new(STDOUT))
        @logger = logger
      end

      #
      # Impliments the RecordLoader::Adapter interface by providing a transaction
      # method. Used by {RecordLoader::Base.create!}. This implimentation
      # yields immediately, but otherwise performs no other functions.
      #
      # @return [Void]
      #
      def transaction
        yield
      end

      #
      # Returns whether we are running in a development environment
      # Determined by looking at RACK_ENV
      #
      # @return [Boolean] True if in development
      #
      def development?
        ENV.fetch('RACK_ENV', 'unknown').casecmp?('development')
      end
    end
  end
end
