# frozen_string_literal: true

require 'record_loader/attribute'

# Rails generator to automatically build record loaders
# @see lib/generators/record_loader/USAGE
class RecordLoaderGenerator < Rails::Generators::NamedBase
  IGNORED_COLUMNS = %w[created_at updated_at].freeze

  source_root File.expand_path('templates', __dir__)

  class_option :record_class, type: :string, default: nil,
                              desc: 'The name of the ActiveRecord class which will be created. eg. User'
  class_option :record_key, type: :string, default: 'name',
                            desc: 'The unique attribute by which record will be identified'

  # Builds all templates in the templates directory
  def create_directories
    directory '.', './'
  end

  # Generally this will only run on generating the first loader
  def initial_setup
    # Copy across the application_record_loader.rb unless it already exists
    copy_file '../static_files/application_record_loader.rb',
              'lib/record_loader/application_record_loader.rb',
              skip: true
    # Copy across the record_loader.rake unless it already exists
    copy_file '../static_files/record_loader.rake',
              'lib/tasks/record_loader.rake',
              skip: true
  end

  def build_example_hash(size = 2)
    (1..size).each_with_object({}) do |iteration, store|
      store["Unique #{record_key} #{iteration}"] = loader_attributes.each_with_object({}) do |attribute, config|
        config[attribute.name] = attribute.value(iteration)
      end
    end
  end

  private

  def klass
    @klass ||= record_class.constantize
  end

  def loader_attributes
    klass.content_columns
         .reject { |column| IGNORED_COLUMNS.include?(column.name) }
         .map { |column| RecordLoader::Attribute.new(column.name, column.type, defaults[column.name]) }
  end

  # The defaults returned by content_columns are not coerced
  def defaults
    klass.column_defaults
  end

  def attributes_values(index)
    loader_attributes.map { |a| "#{a.name}: #{a.ruby_value(index)}" }.join(', ')
  end

  def loader_class_name
    "#{name.camelcase}Loader"
  end

  def record_class
    options['record_class'] || name.camelcase
  end

  def record_key
    options['record_key']
  end

  def underscore_loader
    "#{name.underscore}_loader"
  end

  def underscore
    name.underscore
  end

  def underscores
    underscore.pluralize
  end
end
