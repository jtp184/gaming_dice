FactoryBot.define do
  factory :dice, class: 'GamingDice::Dice' do
    faces { 6 }

    trait :multiple_count do
      count { 2 }
    end

    trait :explodes do
      explodes { true }
    end
  end
end
