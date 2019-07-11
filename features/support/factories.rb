FactoryBot.define do
	factory :dice, class: "GamingDice::Dice" do
		count { 1 }
		faces { 6 }

		trait :multiple_count do
			count { 2 }
		end

		trait :explodes do
			explodes { true }
		end

		trait :bonus do
			bonus { 1 }
		end
	end
end