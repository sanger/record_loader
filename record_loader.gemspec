# frozen_string_literal: true

require_relative 'lib/record_loader/version'

Gem::Specification.new do |spec|
  spec.name          = 'record_loader'
  spec.version       = RecordLoader::VERSION
  spec.authors       = ['Sanger - Production Software Development']
  spec.email         = ['psd@sanger.ac.uk']

  spec.summary       = 'Easily manage seeding and updating data from simple yml files'
  spec.description   = 'Provides a simple interface for generating and maintaining database
                        records across multiple environments in a simple and reproducible manner.'
  spec.homepage      = 'https://github.com/sanger/record_loader'
  spec.license       = 'MIT'

  spec.required_ruby_version = '>= 3.1.7'

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  # spec.metadata['allowed_push_host'] = "TODO: Set to your gem server 'https://example.com'"

  spec.metadata['homepage_uri']     = spec.homepage
  spec.metadata['source_code_uri']  = 'https://github.com/sanger/record_loader'
  spec.metadata['changelog_uri']    = 'https://github.com/sanger/record_loader/blob/master/CHANGELOG.md'

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(__dir__) do
    `git ls-files -z`.split("\x0").reject do |f|
      (f == __FILE__) || f.match(%r{\A(?:(?:bin|test|spec|features)/|\.(?:git|travis|circleci)|appveyor)})
    end
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  # Development dependencies
  spec.add_development_dependency 'bundler', '~> 2.3'
  spec.add_development_dependency 'mdtoc', '~> 0.3.1'
  spec.add_development_dependency 'pry', '~> 0.14'
  spec.add_development_dependency 'rake', '~> 13.0'
  spec.add_development_dependency 'rspec', '~> 3.12'
  spec.add_development_dependency 'rubocop', '~> 1.56'
  spec.add_development_dependency 'rubocop-rake', '~> 0.7.1'
  spec.add_development_dependency 'rubocop-rspec', '~> 3.0'
  spec.add_development_dependency 'simplecov', '~> 0.22'
  spec.add_development_dependency 'simplecov-lcov', '~> 0.9'
  spec.add_development_dependency 'yard', '~> 0.9'

  # For more information and examples about making a new gem, check out our
  # guide at: https://bundler.io/guides/creating_gem.html
end
