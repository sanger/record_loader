# frozen_string_literal: true

module RecordLoader
  module Adapter
    # An adapter designed for use with Rails applications. Automatically wraps {RecordLoader::Base.create!} in an
    # active record transaction, and directs logging to the configure rails logger. Environment is extracted
    # from Rails.env
    class Rails
      # Wraps Rails.logger method
      # @return [#debug&#info&#warn#&error&#fatal]
      def logger
        ::Rails.logger
      end

      #
      # Wraps the ActiveRecord::Base.transaction method.
      # @see https://api.rubyonrails.org/classes/ActiveRecord/Transactions/ClassMethods.html
      # @return [Void]
      def transaction(&block)
        ActiveRecord::Base.transaction(&block)
      end

      #
      # Returns whether we are running in a development environment
      #
      # @return [Boolean] True is in development
      #
      def development?
        ::Rails.env.development?
      end
    end
  end
end
