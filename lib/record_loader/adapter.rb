# frozen_string_literal: true

require_relative 'adapter/basic'
require_relative 'adapter/rails'

module RecordLoader
  #
  # {RecordLoader::Adapter}s provide a means of wrapping various framework
  # methods in order to use {RecordLoader} outside of Rails and ActiveRecord.
  #
  # = Existing Adapters
  # There are currently two adapters available
  #
  # - {RecordLoader::Adapter::Basic}
  # A simple general purpose adapter which provides no support for transactions and only basic logging.
  #
  # - {RecordLoader::Adapter::Rails}
  # An adapter designed for use with Rails applications. Automatically wraps {Record::Loader::Base.create!} in an
  # active record transaction, and directs logging to the configure rails logger.
  #
  # = Custom Adapters
  # It is possible to create custom adapters to use with your own frameworks. It is suggested that you inherit from
  # {RecordLoader::Adapter::Basic} to provide forward compatibility with future versions of RecordLoader.
  #
  # Custom adapters should support two instance methods:
  #
  # - transaction(&block)
  # Wraps the {Record::Loader::Base.create!} and allows you to handle transactional rollbacks in the event that
  # something goes wrong. This method recieves a block and should be yielded to to generate the records.
  #
  # - logger
  # Should return a logger object which impliments: debug, info, warn, error, fatal methods
  #
  # @example my_adapter.rb
  #  class MyAdapter < RecordLoader::Adapter::Basic
  #    def transaction
  #      Database.open_transaction
  #      yield
  #      Database.commit_transaction
  #    rescue StandardError
  #      Database.abort_transaction
  #    end
  #
  #    def logger
  #      DistributedLoggingSystem.logger
  #    end
  #  end
  #
  # @example application_record_loader.rb
  #  class ApplicationRecordLoader
  #    adapter MyAdapter.new
  #  end
  module Adapter
  end
end
