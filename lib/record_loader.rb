# frozen_string_literal: true

require 'record_loader/version'
require 'record_loader/base'
require 'record_loader/record_file'

# Root namespace of RecordLoader
module RecordLoader
  # Raised when it appears RecordLoader is improperly configured
  ConfigurationError = Class.new(StandardError)
end
