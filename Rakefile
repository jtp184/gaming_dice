require 'bundler/gem_tasks'

task default: %w[test]

task :test do
  sh 'cucumber'
end

task :docs do
  sh 'rm -rf ./docs'
  sh 'rm README.rdoc'
  sh 'cp README.md README.rdoc'
  sh 'rdoc --format=hanna --all lib'
  sh 'mv doc docs'
end

task prep: %i[test docs]

task gitgo: [:prep] do
  sh 'git add . && git commit && git push'
end
