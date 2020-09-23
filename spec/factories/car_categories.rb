FactoryBot.define do
  factory :car_category do
    sequence(:name) {|i| "B#{i}"}
    daily_rate { 100 }
    car_insurance { 100 }
    third_party_insurance { 100 }
  end
end