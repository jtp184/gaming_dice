Given(/included the monkey patches/i) do
	require 'gaming_dice/patches'
end

Given(/have an integer/i) do
	@int = 1
end

Given(/send the message "(\w*)" to the integer/) do |string|
	mtd = string.to_sym
	@result = @int.public_send(mtd)
end

Given(/message "(\w*)" with an integer argument/i) do |string|
	mtd = string.to_sym
	@int_arg = rand(100)
	@result = @int.public_send(mtd, @int_arg)
end

Then(/i receive a dice with (\d+) faces/i) do |int|
	expect(@result.faces).to eq(int)
end

Then(/receive a dice with the right number of faces/i) do
	expect(@result.faces).to eq(@int_arg)
end
