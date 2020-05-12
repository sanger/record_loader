# RecordLoader

RecordLoader provides a simple and standardized way of populating databases from information described in a series of
organized yaml files. It is intended to be used to generate a number of idempotent tasks, which can be run in both
your production and development environments.

While written with ActiveRecord/Rails in mind, it is possible to use RecordLoader in different environments.

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

## Usage

TODO: Write usage instructions here

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at <https://github.com/sanger/record_loader>.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
