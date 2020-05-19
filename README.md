
# RecordLoader

![Cops and Specs](https://github.com/sanger/record_loader/workflows/Cops%20and%20Specs/badge.svg)
[![Maintainability](https://api.codeclimate.com/v1/badges/0ce827d110dfced197ab/maintainability)](https://codeclimate.com/github/sanger/record_loader/maintainability)
[![Test Coverage](https://api.codeclimate.com/v1/badges/0ce827d110dfced197ab/test_coverage)](https://codeclimate.com/github/sanger/record_loader/test_coverage)
[![Yard Docs](http://img.shields.io/badge/yard-docs-blue.svg)](https://rubydoc.info/github/sanger/record_loader)

RecordLoader provides a simple and standardized way of populating databases from information described in a series of
organized yaml files. It is intended to be used to generate a number of idempotent tasks, which can be run in both
your production and development environments.

While written with ActiveRecord/Rails in mind, it is possible to use RecordLoader in different environments.

## Key features

- Produce testable, reproducible data migrations across multiple environments
- Organize data into multiple files to provide context
- Add development environment specific data with .dev.yml files
- Keep work-in-progress isolated with .wip.yml files
- Rails generators to quickly create new record loaders

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'record_loader'
```

And then execute:

```bash
    bundle
```

Or install it yourself as:

```bash
    gem install record_loader
```

If you are using Rails, you do not need to make any further changes, and all necessary hooks will be installed when
generating your first record loader.

## Usage (Rails)

RecordLoader provides a generator to automatically build a loader, specs and the yaml files necessary to use it.
In addition, the first time you use it it will automatically install the necessary rake files and configuration.
You can access this by running:

```bash
    bundle exec rails g record_loader
```

Which will return the documentation:

{include:file:lib/generators/record_loader/USAGE}

### An example loader

Suppose you want to create a loader to maintain a selection of product types. You'll first use the generator:

```bash
  $ bundle exec rails g record_loader
       exist
      create  config/record_loader/product_types/default_records.yml
      create  lib/record_loader/product_type_loader.rb
      create  lib/record_loader/tasks/record_loader/product_type.rake
      create  spec/data/record_loader/product_types/two_entry_example.yml
      create  spec/lib/record_loader/product_type_loader_spec.rb
        skip  lib/record_loader/application_record_loader.rb
   identical  lib/tasks/record_loader.rake
```

This will create several files:

#### `lib/tasks/record_loader.rake`

Adds the record_loader:all rake task which can be used to trigger all record loaders.

#### `lib/record_loader/application_record_loader.rb`

Application specific base class for customization.

#### `config/record_loader/product_types/default_records.yml`

Example yaml file to begin populating with your record information. Record Loaders will load all yaml files from within
this directory, so it is possible to separate your records into multiple different files for better organization.
In addition yaml files ending in `.dev.yml` and `.wip.yml` exhibit special behaviour.
See [dev and wip files](#dev-and-wip).

#### `lib/record_loader/product_type_loader.rb`

The actual loader. It will look something like this:

```ruby
# frozen_string_literal: true
# This file was automatically generated via `rails g record_loader`

# RecordLoader handles automatic population and updating of database records
# across different environments
# @see https://rubydoc.info/github/sanger/record_loader/
module RecordLoader
  # Creates the specified plate types if they are not present
  class ProductTypeLoader < ApplicationRecordLoader
    config_folder 'product_types'

    def create_or_update!(name, options)
      ProductType.create_with(options).find_or_create_by!(name: name)
    end
  end
end
```

The `config_folder` specifies which directory under `config/record_loader` will be used to source the yaml files.
The method `create_or_update!` will create the actual records, and should be idempotent (ie. calling it multiple times will
have the same effect as calling it once). `create_or_update!` will be called once for each entry in the yaml files,
with the first argument being the key, and the second argument being the value, usually a hash of options.

#### `lib/record_loader/tasks/record_loader/product_type.rake`

This contains the `record_loader:product_type` which will trigger the record loader, and also ensures that
`record_loader:product_type` will get invoked on calling `record_loader:all`.

#### `spec/data/record_loader/product_types/two_entry_example.yml`

A basic configuration for testing the loader. Tests use a separate directory to avoid coupling your specs to the data.

#### `spec/lib/record_loader/product_type_loader_spec.rb`

A basic rspec spec file for testing your loader. By default this just confirms that your loader creates the
expected number of records, and that it is idempotent.

## Dev and Wip files

Each loader can have one or more yaml files contained within its config directory. Most files will be aggregated
together and only serve to provide a means of organization. However it is possible to add extra behaviour:

`.dev.yml` files will only be loaded in development environments. This is useful for seeding data for quick testing, but
which will not be needed in production environments. This may include test user accounts, dummy projects or quick
start data.

`.wip.yml` files will only be loaded if explicitly enabled via a WIP environmental variable. For example the file
`my_feature.wip.yml` will run if the WIP env is set to `my_feature`. Multiple WIP flags can be set at the same time by
providing a comma separated list. eg. `WIP=my_feature,other_feature`

If you have an existing feature flag system you can use this instead by adding a `wip_list` method to
`RecordLoader::ApplicationRecordLoader` which returns an array of enabled feature names. For example:

```ruby
  def wip_list
    FeatureFlags.active.pluck(:name)
  end
```

## RecordLoader Dependencies

Sometimes one loader will be dependent on the output of another. If this is the case, you can simply configure
its rake task to use the other as a pre-requisite.

For example

```ruby
namespace :record_loader do
  desc 'Automatically generate Dependent through DependentLoader'
  task dependent: [:environment, :prerequisite] do
    RecordLoader::DependentLoader.new.create!
  end
end
```

## Triggering on deployment

It can be useful to set `rake record_loader:all` to run automatically on deployment.
It is recommend you trigger this after migrations have run.

### Within Sanger PSD

**This section is relevant to developers within the Sanger only. Other users of the Gem should hook into their own deployment systems as they see fit.**

In Production Software Development at the Sanger we have the Ansible deployment project configured to run
`rake application:post_deploy` after migrations for selected applications. If you wish to take advantage of this
uncomment the appropriate line in `lib/tasks/record_loader.rake`. You should also ensure that your application has
the post_deploy tasks enabled by setting the post_deploy to true for your application.

Currently this behaviour is configured as part of the 'rails' role, and will need to be set-up independently for
any non-Rails ruby applications.

## Non Rails Environments

In non-rails environments you can use the {RecordLoader::Adapter::Basic} adapter to avoid Rails specific functionality.
This is the default adapter for {RecordLoader::Base}, although it is still recommended that you create an application
specific class that inherits from this to allow for customization. Your custom record loaders can then inherit from this
class instead.

See {RecordLoader::Adapter} for information about custom adapters.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can
also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the
version number in `version.rb`, ensure the CHANGELOG.md is updated and that everything is committed.
Then run `bundle exec rake release`, which will create a git tag for the version,  push git commits and tags, and push
the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at <https://github.com/sanger/record_loader>.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
