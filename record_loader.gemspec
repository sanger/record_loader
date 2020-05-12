# frozen_string_literal: true

lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'record_loader/version'

Gem::Specification.new do |spec|
  spec.name          = 'record_loader'
  spec.version       = RecordLoader::VERSION
  spec.authors       = ['James Glover']
  spec.email         = ['james.glover@sanger.ac.uk']

  spec.summary       = 'Easily manage seeding and updating data from simple yml files'
  spec.description   = 'Provides a simple interface for generating and maintaining database
                          records across multiple environments in a simple and reproducible manner.'
  spec.homepage      = 'https://www.github.com/sanger/record_loader'
  spec.license       = 'MIT'

  spec.required_ruby_version = '>= 2.5.0'

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    # spec.metadata["allowed_push_host"] = "TODO: Set to 'http://mygemserver.com'"

    spec.metadata['homepage_uri'] = spec.homepage
    spec.metadata['source_code_uri'] = 'https://www.github.com/sanger/record_loader'
    # spec.metadata["changelog_uri"] = "TODO: Put your gem's CHANGELOG.md URL here."
  else
    raise 'RubyGems 2.0 or newer is required to protect against ' \
      'public gem pushes.'
  end

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  # Development dependencies
  spec.add_development_dependency 'bundler', '~> 2.1'
  spec.add_development_dependency 'pry', '~> 0.13'
  spec.add_development_dependency 'rake', '~> 12.3'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'rubocop', '~> 0.82'
  spec.add_development_dependency 'rubocop-rspec', '~> 1.39'
  spec.add_development_dependency 'yard', '~> 0.9'
  # Pin simplecov to ~> 0.17 until CodeClimate compatibility
  # issues resolved:
  # https://github.com/codeclimate/test-reporter/issues/413
  spec.add_development_dependency 'simplecov', '~> 0.17'
end
