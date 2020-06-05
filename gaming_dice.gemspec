lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'gaming_dice/version'

Gem::Specification.new do |spec|
  spec.name          = 'gaming_dice'
  spec.version       = GamingDice::VERSION
  spec.authors       = ['Justin Piotroski']
  spec.email         = ['justin.piotroski@gmail.com']

  spec.summary       = 'A Gem to model polyhedral dice'
  spec.homepage      = 'http://github.com/jtp184/gaming_dice'

  # Prevent pushing this gem to RubyGems.org. To allow pushes either 
  # set the 'allowed_push_host' to allow pushing to a single host or
  # delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com'"
  else
    raise 'RubyGems 2.0 or newer is required to protect against ' \
      'public gem pushes.'
  end

  spec.files = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.15'
  spec.add_development_dependency 'cucumber', '~> 3.1.2'
  spec.add_development_dependency 'factory_bot', '~> 5.0.2'
  spec.add_development_dependency 'pry'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'simplecov'
end
