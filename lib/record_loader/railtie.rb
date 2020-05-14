# frozen_string_literal: true

module RecordLoader
  # Adds Railtie hooks for Rails usage
  # This class is only loaded if rails is detected
  # This sets up the generators
  class Railtie < Rails::Railtie
  end
end
