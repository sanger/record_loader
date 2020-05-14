# frozen_string_literal: true

require 'record_loader/version'
require 'record_loader/adapter'
require 'record_loader/base'
require 'record_loader/record_file'

# Only load the railtie is we detect rails
require 'record_loader/railtie' if defined?(Rails)

# Root namespace of RecordLoader
module RecordLoader
  # Raised when it appears RecordLoader is improperly configured
  ConfigurationError = Class.new(StandardError)
end
