$LOAD_PATH.unshift File.expand_path('../lib', __FILE__)
require 'padrino-flash/version'

require 'rake'
require 'yard'
require 'rspec'
require 'rspec/core/rake_task'

RSpec::Core::RakeTask.new do |task|
  task.pattern = 'spec/**/*_spec.rb'
end

YARD::Rake::YardocTask.new

task :build do
  `gem build padrino-flash.gemspec`
end

task :install => :build do
  `gem install padrino-flash-#{Padrino::Flash::VERSION}.gem`
end

desc 'Releases the current version into the wild'
task :release => :build do
  `git tag -a v#{Padrino::Flash::VERSION} -m "Version #{Padrino::Flash::VERSION}"`
  `gem push padrino-flash-#{Padrino::Flash::VERSION}.gem`
  `git push --tags`
end

task :default => :spec