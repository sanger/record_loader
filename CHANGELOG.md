# Changelog

Keeps track of notable changes. Please remember to add new behaviours to the
Unreleased section to make new releases easy.

## [Unreleased]

- [Added] `RecordLoader.export_attributes` for easy generation of yaml from
           existing data
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
