FactoryBot.define do
  factory :post do
    title { Faker::TvShows::GameOfThrones.quote }
    body { Faker::Lorem.paragraph }
  end
end
