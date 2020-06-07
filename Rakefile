require 'bundler/gem_tasks'

task default: %w[test]

task :test do
  sh 'cucumber'
end

task :docs do
  rdx = %w[tmp pkg bin coverage docs features].map { |e| "--exclude=#{e}" }
  sh "rdoc --output=docs --format=hanna --all --main=README.md #{rdx.join(' ')}"
end

task prep: %i[test docs]

task :reinstall do
  sh 'gem uninstall gaming_dice'
  Rake::Task['install'].invoke
end

task :bump do
  repo = Git.open('.')
  version_file = './lib/gaming_dice/version.rb'
  matcher = /VERSION = "(.*)"\.freeze/

  file_contents = File.read(version_file)

  updated = file_contents.gsub(matcher) do |v|
    v.gsub Regexp.last_match(1), Regexp.last_match(1).succ
  end

  File.open(version_file, 'w+') { |f| f << updated }

  sh 'bundle'

  repo.add(version_file)
  repo.add('Gemfile.lock')
end
