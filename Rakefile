# frozen_string_literal: true

# We add preflight to the release task pre-requisites before loading in the
# bundler/gem_tasks to ensure that it runs first. This is because 'release' is
# actually composed entirely of pre-requisites and so would otherwise end up
# running the pre-flight tasks AFTER everything else
task release: :preflight

require 'bundler/gem_tasks'
require 'rainbow/refinement'
require 'rspec/core/rake_task'
require 'rubocop/rake_task'

using Rainbow

RSpec::Core::RakeTask.new(:spec)
RuboCop::RakeTask.new

task default: %i[rubocop spec]

desc 'Runs the preflight checklist before building a release'
task :preflight do
  puts '──────────────────────'.bright
  puts '🛫 Preflight checklist'.bright
  puts '──────────────────────'.bright

  current_version = RecordLoader::VERSION
  latest_changelog_entry = File.read('CHANGELOG.md').scan(/^## \[(.*?)\]/).flatten.first
  latest_master = latest_master?

  puts 'Before we roll a release, lets confirm a few things:'
  puts
  puts "▢ Has the gem version been updated? Currently #{st(current_version)} in #{p('lib/record_loader/version.rb')} "
  puts "▢ Has the changelog been updated? Latest entry is #{st(latest_changelog_entry)} in #{p('CHANGELOG.md')}"
  puts "▢ Are all changes committed to git? #{yn(uncommitted_changes?)}"
  puts "▢ Are you on master and up to date? #{yn(on_master? & latest_master)}"
  puts
  puts 'Proceeding will package the gem, create a git tag for the version, ' \
       'push commits and tags to GitHub, and push the .gem file to rubygems.org.'.italic
  puts 'We do not currently have an accessible team account on rubygems.org, so this final step can be skipped.'.italic
  puts
  print 'Proceed [y/N] > '

  proceed = $stdin.gets.chomp

  if proceed.casecmp? 'Y'
    puts 'Proceeding ...'
  else
    puts 'Canceling release process'
    exit 1
  end
end

private

# Highlight the provided path in cyan for better visibility in the terminal
def p(path)
  Rainbow(path).bright.cyan
end

# Highlight the provided status in bright for better visibility in the terminal
def st(status)
  Rainbow(status).bright
end

# Given a boolean value, return Yes or No, or 'N/A' if the value is nil
def yn(value)
  return 'N/A' if value.nil?

  value ? 'Yes'.bright.green : 'No'.bright.red
end

def uncommitted_changes?
  `git status --porcelain`.empty?
end

def on_master?
  `git rev-parse --abbrev-ref HEAD`.chomp == 'master'
end

def latest_master?
  !`git remote show origin | grep "pushes to master" | grep "(up to date)"`.empty?
end
