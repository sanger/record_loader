class RecordLoaderGenerator < Rails::Generators::NamedBase
  source_root File.expand_path('templates', __dir__)

  class_option :record_class, type: :string, default: nil,
               desc: 'The name of the ActiveRecord class which will be created. eg. User'
  class_option :record_key, type: :string, default: 'name',
               desc: 'The unique attribute by which record will be identified'

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

  private

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
