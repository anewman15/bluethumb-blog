FactoryBot.define do
  factory :comment do
    name { Faker::Name.first_name }
    body { Faker::Lorem.paragraph }
  end
end
