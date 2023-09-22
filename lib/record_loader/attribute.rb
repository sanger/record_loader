# frozen_string_literal: true

require 'date'

module RecordLoader
  # Used by the generator to help guide the generation of the initial
  # yaml files
  class Attribute
    BASE_TIME = Time.parse('2021-10-08 13:00:40 +0100')
    BASE_DATE = Date.parse('2021-10-08')

    # @return [String] The name of the attribute, takes the column name
    attr_reader :name

    # @return [Symbol] The attribute type (eg. :string) as returned by the rails connection adapter
    attr_reader :type

    # @return [Object] The default of the attribute
    attr_reader :default

    #
    # Create a new attribute
    #
    # @param name [String] The name of the attribute, takes the column name
    # @param type [Symbol] The attribute type (eg. :string) as returned by the rails connection adapter
    # @param default [Object] The default value of the column
    #
    def initialize(name, type, default)
      @name = name
      @type = type
      @default = default
    end

    def value(index)
      if @default.nil?
        value_for_type(index)
      else
        @default
      end
    end

    def ruby_value(index)
      case type
      when :datetime, :timestamp then "Time.parse('#{value(index)}')"
      when :date then "Date.parse('#{value(index)}')"
      else
        value(index).inspect
      end
    end

    private

    # If this gets much more complicated then consider separate classes for
    # handling the type specific behaviour. Avoiding for now as I'm not sure it
    # adds much
    def value_for_type(index)
      case type
      when :integer then index
      when :datetime, :timestamp then BASE_TIME + index
      when :date then BASE_DATE + index
      when :boolean then false
      when :float, :decimal then index.to_f
      when :json then {}
      else # Covers string and text, but also a fallback for other column types
        "#{name.tr('_', ' ')} #{index}"
      end
    end
  end
end
