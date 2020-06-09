require 'simplecov'

SimpleCov.start do
	add_filter 'features'
end

require 'gaming_dice'
require 'factory_bot'

World(FactoryBot::Syntax::Methods)
