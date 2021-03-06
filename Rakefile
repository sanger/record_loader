# frozen_string_literal: true

# We add preflight to the release task pre-requisites before loading in the
# bundler/gem_tasks to ensure that it runs first. This is becuase 'release' is
# actually composed entirely of pre-requisites and so would otherwise end up
# running the pre-flight tasks AFTER everything else
task release: :preflight

require 'bundler/gem_tasks'
require 'rspec/core/rake_task'
require 'rubocop/rake_task'

RSpec::Core::RakeTask.new(:spec)
RuboCop::RakeTask.new

task default: %i[rubocop spec]

desc 'Runs the preflight checklist before building a release'
task :preflight do
  puts '🛫 Preflight checklist'

  current_version = RecordLoader::VERSION

  puts 'This is still a manual process, but before we roll a release, lets confirm a few things:'
  puts
  puts "☐ lib/record_loader/version.rb updated? Currently contains #{current_version}"
  puts '☐ CHANGELOG.md updated'
  puts '☐ Commited, on master and up to date'
  puts
  print 'Proceed Y/N > '

  proceed = $stdin.gets.chomp

  if proceed.casecmp? 'Y'
    puts 'Proceeding ...'
  else
    puts 'Canceling release process'
    exit 1
  end
end
