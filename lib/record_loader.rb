# frozen_string_literal: true

require 'record_loader/version'
require 'record_loader/adapter'
require 'record_loader/filter'
require 'record_loader/base'
require 'record_loader/record_file'

# Only load the railtie is we detect rails
require 'record_loader/railtie' if defined?(Rails)

# Root namespace of RecordLoader
module RecordLoader
  # Raised when it appears RecordLoader is improperly configured
  ConfigurationError = Class.new(StandardError)

  #
  # Helper method to automatically generate config yaml for existing data.
  # This method does not handle setting up associations as the best way of
  # serializing that information is left up to the individual RecordLoader
  #
  # @param [ActiveRecord::Base] model_class A class to serialize
  # @param [String] key The key to index by (eg. 'name')
  # @return [String] Yaml listing the existing records
  def self.export_attributes(model_class, key)
    model_class.all.each_with_object({}) do |record, store|
      store[record[key]] = record.attributes.except('id', 'updated_at', 'created_at', key)
    end.to_yaml
  end
end
