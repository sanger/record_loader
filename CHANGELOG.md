# Changelog

Keeps track of notable changes. Please remember to add new behaviours to the
Unreleased section to make new releases easy.  
Follows [Keep a Changelog](https://keepachangelog.com/en/1.1.0/) and [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [1.1.0]

- [Removed] Remove support for Ruby 3.0 - 3.2
- [Changed] Update Psych dependency to explicitly use unsafe loading
- [Fixed] Update development dependencies

## [1.0.0]

- [Changed] Version numbering to follow [Ruby Gem versioning guidelines](https://guides.rubygems.org/patterns/)
- [Changed] Explicitly require and use Psych gem for YAML parsing
- [Added] Add support for Ruby 3.1 - 4.0
- [Documentation] Update documentation to reflect changes in versioning and supported Ruby versions

## [0.3.0]

- [Breaking] Remove support for Ruby 2.5
- [Added] Add support for Ruby 3.0

## [0.2.0]

- [Added] `RecordLoader.export_attributes` for easy generation of yaml from
  existing data
- [Added] Improved feedback if exceptions raised during record creation
- [Added] Improved templated yml files to use attributes from table
- [Changed] Update name of yaml files generated as part of tests.
  No changes are required to existing loaders.
- [Fixed] Default yaml files correctly templated

## [0.1.1]

- [Fixed] Preflight task on `rake release` now run prior to release.
- [Fixed] Generators place config files in correct directory
- [Documentation] Improved documentation regarding dependencies
- [Documentation] Improved documentation regarding deployment

## [0.1.0]

Initial release

- [Feature] Produce testable, reproducible data migrations across multiple environments
- [Feature] Organize data into multiple files to provide context
- [Feature] Add development environment specific data with .dev.yml files
- [Feature] Keep work-in-progress isolated with .wip.yml files
- [Feature] Rails generators to quickly create new record loaders
