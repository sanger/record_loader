
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
