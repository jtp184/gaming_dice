require "bundler/gem_tasks"
require "rspec/core/rake_task"

RSpec::Core::RakeTask.new(:spec)

task :docs do
	sh 'rm -rf ./docs'
	sh 'rm README.rdoc'
	sh 'cp README.md README.rdoc'
	sh 'rdoc --format=hanna --all lib'
	sh 'mv doc docs'
end

task :default => :spec
